package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.common.DateUtil;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.model.entity.*;
import cn.gson.financial.kernel.model.mapper.*;
import cn.gson.financial.kernel.model.vo.ReportDataVo;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import cn.gson.financial.kernel.service.ReportTemplateService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    private DateFormat sdf = new SimpleDateFormat("yyyy");

    @Override
    public int batchInsert(List<ReportTemplate> list) {
        return baseMapper.batchInsert(list);
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
    public Map<Integer, ReportDataVo> view(Integer accountSetsId, Long id, Date accountDate) {
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

                    if (template.getType() == 0) {
                        //个科目的期年统计数据
                        detailVos = voucherMapper.selectReportStatistical(accountSetsId, codes, DateUtil.getMonthEnd(accountDate));
                    } else {
                        //资产负债查余额
                        detailVos = voucherMapper.selectReportBalanceStatistical(accountSetsId, codes, DateUtil.getMonthEnd(accountDate));
                    }


                    //先根据期年进行分组，再根据科目 id 进行数据转换
                    Map<String, Map<String, VoucherDetailVo>> collect = detailVos.stream().collect(Collectors.groupingBy(VoucherDetailVo::getSummary, Collectors.toMap(VoucherDetailVo::getSubjectCode, vo -> vo)));

                    Map<String, VoucherDetailVo> periodData = collect.get("本期");
                    Map<String, VoucherDetailVo> yearData = collect.get("本年");

                    //如果本年余额为空
                    if ((yearData.isEmpty() || yearData.values().stream().allMatch(vo -> vo.isNull())) && template.getType() == 1 && sdf.format(accountSets.getEnableDate()).equals(sdf.format(accountDate))) {
                        List<VoucherDetailVo> detailInitVos = voucherMapper.selectReportInitBalance(accountSetsId, codes);
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
