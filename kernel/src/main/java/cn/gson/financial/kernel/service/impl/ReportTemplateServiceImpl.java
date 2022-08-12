package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.common.DateUtil;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.model.entity.*;
import cn.gson.financial.kernel.model.mapper.*;
import cn.gson.financial.kernel.model.vo.ReportDataVo;
import cn.gson.financial.kernel.model.vo.ReportYearDataVo;
import cn.gson.financial.kernel.model.vo.TemplateGrantOrgVo;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import cn.gson.financial.kernel.service.ReportTemplateService;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.service.impl</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
@Slf4j
public class ReportTemplateServiceImpl extends ServiceImpl<ReportTemplateMapper, ReportTemplate> implements ReportTemplateService {

    @Autowired
    private ReportTemplateItemsMapper itemsMapper;

    @Autowired
    private ReportTemplateItemsFormulaMapper formulaMapper;

    @Autowired
    private VoucherMapper voucherMapper;

    @Autowired
    private SubjectMapper subjectMapper;

    @Autowired
    private AccountSetsMapper accountSetsMapper;

    @Autowired
    private OrganizationMapper organizationMapper;

    private DateFormat sdf = new SimpleDateFormat("yyyy");

    @Override
    public int batchInsert(List<ReportTemplate> list) {
        return baseMapper.batchInsert(list);
    }


    @Override
    public boolean save(ReportTemplate entity) {
        super.save(entity);
        if (entity.getCopy()) {
            LambdaQueryWrapper<ReportTemplateItems> itemqw = Wrappers.lambdaQuery();
            itemqw.eq(ReportTemplateItems::getTemplateId, entity.getCopyId());
            List<ReportTemplateItems> reportTemplateItems = itemsMapper.selectList(itemqw);
            Map<Integer, Integer> itemMap = new HashMap<>();

            reportTemplateItems.forEach(item -> {
                Integer itemId = item.getId();
                item.setId(null);
                if (item.getParentId() != null) {
                    item.setParentId(itemMap.get(item.getParentId()));
                }
                item.setTemplateId(entity.getId());
                itemsMapper.insert(item);
                itemMap.put(itemId, item.getId());
                //公式
                LambdaQueryWrapper<ReportTemplateItemsFormula> fqw = Wrappers.lambdaQuery();
                fqw.eq(ReportTemplateItemsFormula::getTemplateId, entity.getCopyId());
                fqw.eq(ReportTemplateItemsFormula::getTemplateItemsId, itemId);
                List<ReportTemplateItemsFormula> formulasList = formulaMapper.selectList(fqw);
                formulasList.forEach(formulas -> {
                    formulas.setId(null);
                    formulas.setTemplateId(entity.getId());
                    formulas.setTemplateItemsId(item.getId());
                    formulaMapper.insert(formulas);
                });
            });

        }
        return true;
    }

    /**
     * 计算报表
     *
     * @param accountSetsId
     * @param id
     * @param accountDate
     * @return
     */
    @Override
    public Map<Integer, ReportDataVo> view(Integer accountSetsId, Long id, Date accountDate, Integer orgId) {
        AccountSets accountSets = accountSetsMapper.selectById(accountSetsId);

        LambdaQueryWrapper<ReportTemplate> qw = Wrappers.lambdaQuery();
        qw.eq(ReportTemplate::getAccountSetsId, accountSetsId);
        qw.eq(ReportTemplate::getId, id);
        ReportTemplate template = this.getOne(qw);
        log.info("{}", template);
        Map<Integer, ReportDataVo> dataVoMap = new HashMap<>();
        if (template.getItems() != null) {
            //先计算表外公式
            template.getItems().stream().filter(rti -> rti.getSources() == 0 && !rti.getIsClassified()).forEach(item -> {
                ReportDataVo dataVo = new ReportDataVo();
                dataVo.setItemId(item.getId());

                //获取计算项
                if (item.getFormulas() != null && !item.getFormulas().isEmpty()) {
                    //所有计算项目的科目 id
                    List<String> fromTags = item.getFormulas().stream().map(ReportTemplateItemsFormula::getFromTag).collect(Collectors.toList());
                    List<Subject> subjectList = subjectMapper.selectBatchIds(fromTags);
                    Map<Integer, Subject> subjectMap = subjectList.stream().collect(Collectors.toMap(Subject::getId, subject -> subject));
                    List<String> codes = subjectList.stream().map(Subject::getCode).collect(Collectors.toList());

                    List<VoucherDetailVo> detailVos;

                    if (template.getType() == 0 || template.getType() == 2) {
                        //个科目的期年统计数据
                        detailVos = voucherMapper.selectReportStatistical(accountSetsId, codes, DateUtil.getMonthEnd(accountDate), orgId);
                    } else {
                        //资产负债查余额
                        detailVos = voucherMapper.selectReportBalanceStatistical(accountSetsId, codes, DateUtil.getMonthEnd(accountDate), orgId);
                    }


                    //先根据期年进行分组，再根据科目 id 进行数据转换
                    Map<String, Map<String, VoucherDetailVo>> collect = detailVos.stream().collect(Collectors.groupingBy(VoucherDetailVo::getSummary, Collectors.toMap(VoucherDetailVo::getSubjectCode, vo -> vo)));

                    Map<String, VoucherDetailVo> periodData = collect.get("本期");
                    Map<String, VoucherDetailVo> yearData = collect.get("本年");

                    //如果本年余额为空
                    if ((yearData.isEmpty() || yearData.values().stream().allMatch(vo -> vo.isNull())) && template.getType() == 1 && sdf.format(accountSets.getEnableDate()).equals(sdf.format(accountDate))) {
                        List<VoucherDetailVo> detailInitVos = voucherMapper.selectReportInitBalance(accountSetsId, codes, orgId);
                        yearData = detailInitVos.stream().collect(Collectors.groupingBy(VoucherDetailVo::getSummary, Collectors.toMap(VoucherDetailVo::getSubjectCode, vo -> vo))).get("本年");
                    }

                    //计算公式合计
                    dataVo.setCurrentPeriodAmount(getaCombined(subjectMap, item, periodData));
                    dataVo.setCurrentYearAmount(getaCombined(subjectMap, item, yearData));
                }

                dataVoMap.put(item.getId(), dataVo);
            });

            //表内
            template.getItems().stream().filter(rti -> rti.getSources() == 1 && !rti.getIsClassified()).forEach(item -> {
                ReportDataVo dataVo = new ReportDataVo();
                dataVo.setItemId(item.getId());
                Double periodNum = null;
                Double yearNum = null;
                if (item.getFormulas() != null && !item.getFormulas().isEmpty()) {
                    for (ReportTemplateItemsFormula formula : item.getFormulas()) {
                        //获取表内已计算的
                        ReportDataVo dataVo1 = dataVoMap.get(Integer.parseInt(formula.getFromTag()));
                        if (dataVo1 != null) {
                            if (periodNum == null) {
                                periodNum = dataVo1.getCurrentPeriodAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        periodNum += DoubleValueUtil.getNotNullVal(dataVo1.getCurrentPeriodAmount());
                                        break;
                                    case "-":
                                        periodNum -= DoubleValueUtil.getNotNullVal(dataVo1.getCurrentPeriodAmount());
                                        break;
                                }
                            }

                            if (yearNum == null) {
                                yearNum = dataVo1.getCurrentYearAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        yearNum += DoubleValueUtil.getNotNullVal(dataVo1.getCurrentYearAmount());
                                        break;
                                    case "-":
                                        yearNum -= DoubleValueUtil.getNotNullVal(dataVo1.getCurrentYearAmount());
                                        break;
                                }
                            }
                        }
                    }
                }
                dataVo.setCurrentPeriodAmount(periodNum);
                dataVo.setCurrentYearAmount(yearNum);
                dataVoMap.put(item.getId(), dataVo);
            });
        }
        return dataVoMap;
    }

    @Override
    public Map<Integer, ReportYearDataVo> yearProfitStatement(Integer accountSetsId, Long id, String year, Integer orgId) {

        LambdaQueryWrapper<ReportTemplate> qw = Wrappers.lambdaQuery();
        qw.eq(ReportTemplate::getAccountSetsId, accountSetsId);
        qw.eq(ReportTemplate::getId, id);
        ReportTemplate template = this.getOne(qw);
        log.info("{}", template);
        Map<Integer, ReportYearDataVo> dataVoMap = new HashMap<>();
        if (template.getItems() != null) {
            //先计算表外公式
            template.getItems().stream().filter(rti -> rti.getSources() == 0 && !rti.getIsClassified()).forEach(item -> {
                ReportYearDataVo dataVo = new ReportYearDataVo();
                dataVo.setItemId(item.getId());
                //获取计算项
                if (item.getFormulas() != null && !item.getFormulas().isEmpty()) {
                    //所有计算项目的科目 id
                    List<String> fromTags = item.getFormulas().stream().map(ReportTemplateItemsFormula::getFromTag).collect(Collectors.toList());
                    List<Subject> subjectList = subjectMapper.selectBatchIds(fromTags);
                    Map<Integer, Subject> subjectMap = subjectList.stream().collect(Collectors.toMap(Subject::getId, subject -> subject));
                    List<String> codes = subjectList.stream().map(Subject::getCode).collect(Collectors.toList());

                    List<VoucherDetailVo> detailVos;

                    //个科目的月度与年统计数据
                    detailVos = voucherMapper.selectYearReportStatistical(accountSetsId, codes, year, orgId);
                    log.info("detailVos:{}", JSON.toJSONString(detailVos));
                    //先根据期年进行分组，再根据科目 id 进行数据转换
                    Map<String, Map<String, VoucherDetailVo>> collect = detailVos.stream().collect(Collectors.groupingBy(VoucherDetailVo::getSummary, Collectors.toMap(VoucherDetailVo::getSubjectCode, vo -> vo)));

                    Map<String, VoucherDetailVo> januaryData = collect.get(year + "01");
                    Map<String, VoucherDetailVo> februaryData = collect.get(year + "02");
                    Map<String, VoucherDetailVo> marchData = collect.get(year + "03");
                    Map<String, VoucherDetailVo> aprilData = collect.get(year + "04");
                    Map<String, VoucherDetailVo> mayData = collect.get(year + "05");
                    Map<String, VoucherDetailVo> juneData = collect.get(year + "06");
                    Map<String, VoucherDetailVo> julyData = collect.get(year + "07");
                    Map<String, VoucherDetailVo> augustData = collect.get(year + "08");
                    Map<String, VoucherDetailVo> septemberData = collect.get(year + "09");
                    Map<String, VoucherDetailVo> octoberData = collect.get(year + "10");
                    Map<String, VoucherDetailVo> novemberData = collect.get(year + "11");
                    Map<String, VoucherDetailVo> decemberData = collect.get(year + "12");
                    Map<String, VoucherDetailVo> yearData = collect.get("本年");


                    //计算公式合计
                    dataVo.setJanuaryAmount(getaCombined(subjectMap, item, januaryData));
                    dataVo.setFebruaryAmount(getaCombined(subjectMap, item, februaryData));
                    dataVo.setMarchAmount(getaCombined(subjectMap, item, marchData));
                    dataVo.setAprilAmount(getaCombined(subjectMap, item, aprilData));
                    dataVo.setMayAmount(getaCombined(subjectMap, item, mayData));
                    dataVo.setJuneAmount(getaCombined(subjectMap, item, juneData));
                    dataVo.setJulyAmount(getaCombined(subjectMap, item, julyData));
                    dataVo.setAugustAmount(getaCombined(subjectMap, item, augustData));
                    dataVo.setSeptemberAmount(getaCombined(subjectMap, item, septemberData));
                    dataVo.setOctoberAmount(getaCombined(subjectMap, item, octoberData));
                    dataVo.setNovemberAmount(getaCombined(subjectMap, item, novemberData));
                    dataVo.setDecemberAmount(getaCombined(subjectMap, item, decemberData));
                    dataVo.setCurrentYearAmount(getaCombined(subjectMap, item, yearData));
                }

                dataVoMap.put(item.getId(), dataVo);
            });

            //表内
            template.getItems().stream().filter(rti -> rti.getSources() == 1 && !rti.getIsClassified()).forEach(item -> {
                ReportYearDataVo dataVo = new ReportYearDataVo();
                dataVo.setItemId(item.getId());
                Double januaryNum = null;
                Double februaryNum = null;
                Double marchNum = null;
                Double aprilNum = null;
                Double mayNum = null;
                Double juneNum = null;
                Double julyNum = null;
                Double augustNum = null;
                Double septemberNum = null;
                Double octoberNum = null;
                Double novemberNum = null;
                Double decemberNum = null;
                Double yearNum = null;
                if (item.getFormulas() != null && !item.getFormulas().isEmpty()) {
                    for (ReportTemplateItemsFormula formula : item.getFormulas()) {
                        //获取表内已计算的
                        ReportYearDataVo dataVo1 = dataVoMap.get(Integer.parseInt(formula.getFromTag()));
                        if (dataVo1 != null) {
                            if (januaryNum == null) {
                                januaryNum = dataVo1.getJanuaryAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        januaryNum += DoubleValueUtil.getNotNullVal(dataVo1.getJanuaryAmount());
                                        break;
                                    case "-":
                                        januaryNum -= DoubleValueUtil.getNotNullVal(dataVo1.getJanuaryAmount());
                                        break;
                                }
                            }
                            if (februaryNum == null) {
                                februaryNum = dataVo1.getFebruaryAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        februaryNum += DoubleValueUtil.getNotNullVal(dataVo1.getFebruaryAmount());
                                        break;
                                    case "-":
                                        februaryNum -= DoubleValueUtil.getNotNullVal(dataVo1.getFebruaryAmount());
                                        break;
                                }
                            }
                            if (marchNum == null) {
                                marchNum = dataVo1.getMarchAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        marchNum += DoubleValueUtil.getNotNullVal(dataVo1.getMarchAmount());
                                        break;
                                    case "-":
                                        marchNum -= DoubleValueUtil.getNotNullVal(dataVo1.getMarchAmount());
                                        break;
                                }
                            }
                            if (aprilNum == null) {
                                aprilNum = dataVo1.getAprilAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        aprilNum += DoubleValueUtil.getNotNullVal(dataVo1.getAprilAmount());
                                        break;
                                    case "-":
                                        aprilNum -= DoubleValueUtil.getNotNullVal(dataVo1.getAprilAmount());
                                        break;
                                }
                            }
                            if (mayNum == null) {
                                mayNum = dataVo1.getMayAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        mayNum += DoubleValueUtil.getNotNullVal(dataVo1.getMayAmount());
                                        break;
                                    case "-":
                                        mayNum -= DoubleValueUtil.getNotNullVal(dataVo1.getMayAmount());
                                        break;
                                }
                            }
                            if (juneNum == null) {
                                juneNum = dataVo1.getJuneAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        juneNum += DoubleValueUtil.getNotNullVal(dataVo1.getJuneAmount());
                                        break;
                                    case "-":
                                        juneNum -= DoubleValueUtil.getNotNullVal(dataVo1.getJuneAmount());
                                        break;
                                }
                            }
                            if (julyNum == null) {
                                julyNum = dataVo1.getJulyAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        julyNum += DoubleValueUtil.getNotNullVal(dataVo1.getJulyAmount());
                                        break;
                                    case "-":
                                        julyNum -= DoubleValueUtil.getNotNullVal(dataVo1.getJulyAmount());
                                        break;
                                }
                            }
                            if (augustNum == null) {
                                augustNum = dataVo1.getAugustAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        augustNum += DoubleValueUtil.getNotNullVal(dataVo1.getAugustAmount());
                                        break;
                                    case "-":
                                        augustNum -= DoubleValueUtil.getNotNullVal(dataVo1.getAugustAmount());
                                        break;
                                }
                            }
                            if (septemberNum == null) {
                                septemberNum = dataVo1.getSeptemberAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        septemberNum += DoubleValueUtil.getNotNullVal(dataVo1.getSeptemberAmount());
                                        break;
                                    case "-":
                                        septemberNum -= DoubleValueUtil.getNotNullVal(dataVo1.getSeptemberAmount());
                                        break;
                                }
                            }
                            if (octoberNum == null) {
                                octoberNum = dataVo1.getOctoberAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        octoberNum += DoubleValueUtil.getNotNullVal(dataVo1.getOctoberAmount());
                                        break;
                                    case "-":
                                        octoberNum -= DoubleValueUtil.getNotNullVal(dataVo1.getOctoberAmount());
                                        break;
                                }
                            }
                            if (novemberNum == null) {
                                novemberNum = dataVo1.getNovemberAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        novemberNum += DoubleValueUtil.getNotNullVal(dataVo1.getNovemberAmount());
                                        break;
                                    case "-":
                                        novemberNum -= DoubleValueUtil.getNotNullVal(dataVo1.getNovemberAmount());
                                        break;
                                }
                            }
                            if (decemberNum == null) {
                                decemberNum = dataVo1.getDecemberAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        decemberNum += DoubleValueUtil.getNotNullVal(dataVo1.getDecemberAmount());
                                        break;
                                    case "-":
                                        decemberNum -= DoubleValueUtil.getNotNullVal(dataVo1.getDecemberAmount());
                                        break;
                                }
                            }
                            dataVo.setJanuaryAmount(januaryNum);
                            dataVo.setFebruaryAmount(februaryNum);
                            dataVo.setMarchAmount(marchNum);
                            dataVo.setAprilAmount(aprilNum);
                            dataVo.setMayAmount(mayNum);
                            dataVo.setJuneAmount(juneNum);
                            dataVo.setJulyAmount(julyNum);
                            dataVo.setAugustAmount(augustNum);
                            dataVo.setSeptemberAmount(septemberNum);
                            dataVo.setOctoberAmount(octoberNum);
                            dataVo.setNovemberAmount(novemberNum);
                            dataVo.setDecemberAmount(decemberNum);
                            if (yearNum == null) {
                                yearNum = dataVo1.getCurrentYearAmount();
                            } else {
                                switch (formula.getCalculation().toString()) {
                                    case "+":
                                        yearNum += DoubleValueUtil.getNotNullVal(dataVo1.getCurrentYearAmount());
                                        break;
                                    case "-":
                                        yearNum -= DoubleValueUtil.getNotNullVal(dataVo1.getCurrentYearAmount());
                                        break;
                                }
                            }
                        }
                    }
                }

                dataVo.setCurrentYearAmount(yearNum);
                dataVoMap.put(item.getId(), dataVo);
            });
        }
        return dataVoMap;
    }

    @Override
    @Transactional
    public int grantOrg(TemplateGrantOrgVo grantOrgVo) {
        int i = 0;
        if (grantOrgVo.getOrgIds() != null && grantOrgVo.getOrgIds().size() > 0 && grantOrgVo.getTemplate() != null) {
            LambdaQueryWrapper<Organization> query;
            query = Wrappers.lambdaQuery();
            query.in(Organization::getId, grantOrgVo.getOrgIds());
            query.eq(Organization::getAccountSetsId, grantOrgVo.getTemplate().getAccountSetsId());

            Organization org = new Organization();
            if (grantOrgVo.getTemplate().getType() == 0) {
                org.setProfitTemplateId(grantOrgVo.getTemplate().getId());
            } else if (grantOrgVo.getTemplate().getType() == 1) {
                org.setDebtTemplateId(grantOrgVo.getTemplate().getId());
            } else if (grantOrgVo.getTemplate().getType() == 2) {
                org.setCashTemplateId(grantOrgVo.getTemplate().getId());
            }
         i =  organizationMapper.update(org, query);
        }
        return i;
    }

    /**
     * 根据工具合计
     *
     * @param item
     * @param periodData
     * @return
     */
    private Double getaCombined(Map<Integer, Subject> codes, ReportTemplateItems item, Map<String, VoucherDetailVo> periodData) {
        double periodNum = 0d;
        if (periodData == null) {
            return periodNum;
        }
        //计算本期合计
        for (ReportTemplateItemsFormula formula : item.getFormulas()) {
            Subject subject = codes.get(Integer.parseInt(formula.getFromTag()));
            VoucherDetailVo vo = periodData.get(subject.getCode());
            if (vo != null) {
                //0: " 净发生额", 1: "借方发生额", 2: "贷方发生额", 3: "余额", 4: "期末余额", 5: "期初余额"
                double money = 0;
                switch (formula.getAccessRules()) {
                    case 0://净发生额
                    case 3://余额
                        switch (subject.getBalanceDirection() + "") {
                            case "借":
                                money = DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
                                break;
                            case "贷":
                                money = DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount());
                                break;
                        }
                        break;
                    case 1://借方发生额
                        money = DoubleValueUtil.getNotNullVal(vo.getDebitAmount());
                        break;
                    case 2://贷方发生额
                        money = DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
                        break;
                    case 4://借方余额
                        money = DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
                        break;
                    case 5://贷方余额
                        money = DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount());
                        break;
                }

                //计算公式
                switch (formula.getCalculation().toString()) {
                    case "+":
                        periodNum += money;
                        break;
                    case "-":
                        periodNum -= money;
                        break;
                }
            }
        }
        return periodNum;
    }

    @Override
    public ReportTemplate getOne(Wrapper<ReportTemplate> queryWrapper) {
        ReportTemplate template = baseMapper.selectOne(queryWrapper);
        LambdaQueryWrapper<ReportTemplateItems> rtiQw = Wrappers.lambdaQuery();
        rtiQw.orderByAsc(ReportTemplateItems::getPos);
        rtiQw.eq(ReportTemplateItems::getTemplateId, template.getId());
        template.setItems(itemsMapper.selectList(rtiQw));

        template.getItems().forEach(it -> {
            LambdaQueryWrapper<ReportTemplateItemsFormula> rtifQw = Wrappers.lambdaQuery();
            rtifQw.eq(ReportTemplateItemsFormula::getTemplateItemsId, it.getId());
            it.setFormulas(formulaMapper.selectList(rtifQw));
        });

        return template;
    }
}
