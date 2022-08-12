package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.vo.InitialBalanceVo;
import cn.gson.financial.kernel.service.AccountingCategoryDetailsService;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherDetailsService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/initial-balance")
@AllArgsConstructor
@Slf4j
public class InitialBalanceController extends BaseCrudController<VoucherDetailsService, VoucherDetails> {

    private SubjectService subjectService;

    private AccountingCategoryDetailsService accountingCategoryDetailsService;

    private static String[] types = new String[]{"资产", "负债", "权益", "成本", "损益"};


    @Override
    public JsonResult list(@RequestParam Map<String, String> params) {
        Integer orgId = Integer.parseInt(params.get("orgId"));
        //TODO 期初数据没有VoucherId/ 详情表需要加 orgId
        List<VoucherDetails> balanceList = this.service.balanceList(this.accountSetsId.get(), params.get("type"), orgId);
        List<VoucherDetails> auxiliaryList = this.service.auxiliaryList(this.accountSetsId.get(), params.get("type"), orgId);
        Map<String, VoucherDetails> detailsMap = balanceList.stream().collect(Collectors.toMap(v -> v.getSubjectId() + v.getSubjectCode(), voucherDetails -> voucherDetails));
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.orderByAsc(Subject::getCode);
        qw.eq(Subject::getAccountSetsId, this.accountSetsId.get());
        qw.eq(Subject::getType, params.get("type"));
        List<Integer> leafs = subjectService.leafList(this.accountSetsId.get());
        ArrayList<InitialBalanceVo> result = subjectService.list(qw).stream().collect(ArrayList::new, (list, subject) -> {
            VoucherDetails details = detailsMap.get(subject.getId() + subject.getCode());
            InitialBalanceVo vo = new InitialBalanceVo();

            setData(vo, details);

            vo.setSubjectId(subject.getId());
            vo.setType(subject.getType());
            vo.setCode(subject.getCode());
            vo.setName(subject.getName());
            vo.setMnemonicCode(subject.getMnemonicCode());
            vo.setBalanceDirection(subject.getBalanceDirection());
            vo.setStatus(subject.getStatus());
            vo.setParentId(subject.getParentId());
            vo.setLevel(subject.getLevel());
            vo.setSystemDefault(subject.getSystemDefault());
            vo.setAccountSetsId(subject.getAccountSetsId());
            vo.setUnit(subject.getUnit());
            vo.setAuxiliaryAccounting(subject.getAuxiliaryAccounting());
            vo.setLeaf(leafs.contains(subject.getId()));
            list.add(vo);
        }, List::addAll);

        auxiliaryList.forEach(voucherDetails -> {
            InitialBalanceVo vo = new InitialBalanceVo();
            Subject subject = voucherDetails.getSubject();
            VoucherDetails details = detailsMap.get(subject.getId() + voucherDetails.getSubjectCode());

            setData(vo, details);

            vo.setSubjectId(voucherDetails.getSubjectId());
            vo.setCode(voucherDetails.getSubjectCode());
            vo.setName(subject.getName() + voucherDetails.getAuxiliaryTitle());
            vo.setBalanceDirection(subject.getBalanceDirection());
            vo.setParentId(subject.getParentId());
            vo.setLevel((short) (subject.getLevel() + 1));
            vo.setSystemDefault(subject.getSystemDefault());
            vo.setAccountSetsId(subject.getAccountSetsId());
            vo.setUnit(subject.getUnit());
            vo.setLeaf(true);
            result.add(vo);
        });

        return JsonResult.successful(result.stream().sorted(Comparator.comparing(Subject::getCode)).collect(Collectors.toList()));
    }

    private void setData(InitialBalanceVo vo, VoucherDetails details) {
        if (details != null) {
            vo.setBeginBalance(DoubleValueUtil.getNotNullVal(details.getDebitAmount(), details.getCreditAmount()));
            vo.setNum(details.getNum());
            vo.setCumulativeCredit(details.getCumulativeCredit());
            vo.setCumulativeDebit(details.getCumulativeDebit());
            vo.setCumulativeCreditNum(details.getCumulativeCreditNum());
            vo.setCumulativeDebitNum(details.getCumulativeDebitNum());
        }
    }

    @Override
    public JsonResult save(@RequestBody VoucherDetails entity) {
        entity.setOrgId(this.currentUser.get().getOrgId());
        JsonResult result = super.save(entity);
        result.setData(entity);
        return result;
    }

    @PostMapping("auxiliary")
    public JsonResult auxiliary(@RequestBody HashMap<String, Object> entity) {
        this.service.saveAuxiliary(this.accountSetsId.get(),this.currentUser.get().getOrgId(), entity);
        return JsonResult.successful();
    }

    @GetMapping("trialBalance")
    public JsonResult trialBalance() {
        Map<String, Map<String, Double>> data = this.service.trialBalance(this.accountSetsId.get(), this.currentUser.get().getOrgId());
        return JsonResult.successful(data);
    }

    /**
     * 1          2      3       4    5             6            7       8   9  10  11   12 13  14  15
     * 科目编码	科目名称	余额方向	单位 是否辅助核算	辅助核算编码	辅助核算名称 	期初余额	借方累计	贷方累计	年初余额
     * 数量	金额	数量	金额	数量	金额	数量	金额
     */
    @GetMapping("download")
    public void download(HttpServletResponse response) throws IOException {
        InputStream excelInputStream = this.getClass().getResourceAsStream("/tpl/InitialBalance.xls");
        HSSFWorkbook workbook = (HSSFWorkbook) WorkbookFactory.create(excelInputStream);
        HSSFSheet sheet = workbook.getSheetAt(0);//写入第一个
        AtomicInteger index = new AtomicInteger(2);//第二行开始
        for (int i = 0; i < types.length; i++) {
            List<InitialBalanceVo> initialBalanceVos = this.bindTypes(types[i], this.currentUser.get().getOrgId());
            for (InitialBalanceVo initialBalanceVo : initialBalanceVos) {
                HSSFRow dtRow = sheet.createRow(index.get());
                dtRow.createCell(0).setCellValue(types[i]);
                dtRow.createCell(1).setCellValue(initialBalanceVo.getCode());
                dtRow.createCell(2).setCellValue(initialBalanceVo.getName());
                dtRow.createCell(3).setCellValue(initialBalanceVo.getBalanceDirection() + "");
                dtRow.createCell(4).setCellValue(initialBalanceVo.getUnit());
                dtRow.createCell(5).setCellValue(initialBalanceVo.getIsAccounting());
                dtRow.createCell(6).setCellValue(initialBalanceVo.getAccountingCategoryDetailsCode());
                dtRow.createCell(7).setCellValue(initialBalanceVo.getAccountingCategoryDetailsName());

                if (initialBalanceVo.getNum() != null && initialBalanceVo.getBeginBalance() != 0) {
                    dtRow.createCell(8).setCellValue(initialBalanceVo.getNum());
                } else {
                    dtRow.createCell(8).setCellValue("");
                }
                if (initialBalanceVo.getBeginBalance() != null && initialBalanceVo.getBeginBalance() != 0) {
                    dtRow.createCell(9).setCellValue(initialBalanceVo.getBeginBalance());
                } else {
                    dtRow.createCell(9).setCellValue("");
                }

                if (initialBalanceVo.getCumulativeDebitNum() != null && initialBalanceVo.getCumulativeDebitNum() != 0) {
                    dtRow.createCell(10).setCellValue(initialBalanceVo.getCumulativeDebitNum());
                } else {
                    dtRow.createCell(10).setCellValue("");
                }
                if (initialBalanceVo.getCumulativeDebit() != null && initialBalanceVo.getCumulativeDebit() != 0) {
                    dtRow.createCell(11).setCellValue(initialBalanceVo.getCumulativeDebit());
                } else {
                    dtRow.createCell(11).setCellValue("");
                }

                if (initialBalanceVo.getCumulativeCreditNum() != null && initialBalanceVo.getCumulativeCreditNum() != 0) {
                    dtRow.createCell(12).setCellValue(initialBalanceVo.getCumulativeCreditNum());
                } else {
                    dtRow.createCell(12).setCellValue("");
                }
                if (initialBalanceVo.getCumulativeCredit() != null && initialBalanceVo.getCumulativeCredit() != 0) {
                    dtRow.createCell(13).setCellValue(initialBalanceVo.getCumulativeCredit());
                } else {
                    dtRow.createCell(13).setCellValue("");
                }

                if (initialBalanceVo.getYearBalanceNum() != null && initialBalanceVo.getYearBalanceNum() != 0) {
                    dtRow.createCell(14).setCellValue(initialBalanceVo.getYearBalanceNum());
                } else {
                    dtRow.createCell(14).setCellValue("");
                }
                if (initialBalanceVo.getYearBalance() != null && initialBalanceVo.getYearBalance() != 0) {
                    dtRow.createCell(15).setCellValue(initialBalanceVo.getYearBalance());
                } else {
                    dtRow.createCell(15).setCellValue("");
                }
                index.getAndIncrement();
            }
        }
        String fileName = "科目余额期初数据.xls";
        response.setContentType("application/vnd.ms-excel;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
        workbook.write(response.getOutputStream());
        workbook.close();
    }

    private List<InitialBalanceVo> bindTypes(String type, Integer orgId) {
        List<VoucherDetails> balanceList = this.service.balanceList(this.accountSetsId.get(), type, orgId);
        List<VoucherDetails> auxiliaryList = this.service.auxiliaryList(this.accountSetsId.get(), type, orgId);
        Map<String, VoucherDetails> detailsMap = balanceList.stream().collect(Collectors.toMap(v -> v.getSubjectId() + v.getSubjectCode(), voucherDetails -> voucherDetails));
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.orderByAsc(Subject::getCode);
        qw.eq(Subject::getAccountSetsId, this.accountSetsId.get());
        qw.eq(Subject::getType, type);
        Map<Integer, InitialBalanceVo> result = new LinkedHashMap<>();
        subjectService.list(qw).forEach(subject -> {
            VoucherDetails details = detailsMap.get(subject.getId() + subject.getCode());
            InitialBalanceVo vo = new InitialBalanceVo();
            setData(vo, details);
            vo.setParentId(subject.getParentId());
            vo.setType(subject.getType());
            vo.setCode(subject.getCode());
            vo.setName(subject.getName());
            vo.setBalanceDirection(subject.getBalanceDirection());
            vo.setUnit(subject.getUnit());
            vo.setAuxiliaryAccounting(subject.getAuxiliaryAccounting());
            vo.setIsAccounting("否");
            Double yearBalance = Optional.ofNullable(vo.getBeginBalance()).orElse(0d) -
                    (Optional.ofNullable(vo.getCumulativeDebit()).orElse(0d) - Optional.ofNullable(vo.getCumulativeCredit()).orElse(0d));
            Double yearBalanceNum = Optional.ofNullable(vo.getNum()).orElse(0d) -
                    (Optional.ofNullable(vo.getCumulativeDebitNum()).orElse(0d) - Optional.ofNullable(vo.getCumulativeCreditNum()).orElse(0d));
            vo.setYearBalance(yearBalance);
            vo.setYearBalanceNum(yearBalanceNum);
            //上级合计
            setParentData(vo, subject.getParentId(), result);
            result.put(subject.getId(), vo);
        });

        auxiliaryList.forEach(voucherDetails -> {
            InitialBalanceVo vo = new InitialBalanceVo();
            Subject subject = voucherDetails.getSubject();
            VoucherDetails details = detailsMap.get(subject.getId() + voucherDetails.getSubjectCode());
            setData(vo, details);
            Double yearBalance = Optional.ofNullable(vo.getBeginBalance()).orElse(0d) -
                    (Optional.ofNullable(vo.getCumulativeDebit()).orElse(0d) - Optional.ofNullable(vo.getCumulativeCredit()).orElse(0d));
            Double yearBalanceNum = Optional.ofNullable(vo.getNum()).orElse(0d) -
                    (Optional.ofNullable(vo.getCumulativeDebitNum()).orElse(0d) - Optional.ofNullable(vo.getCumulativeCreditNum()).orElse(0d));
            vo.setYearBalance(yearBalance);
            vo.setYearBalanceNum(yearBalanceNum);
            if (StringUtils.isNotEmpty(voucherDetails.getAuxiliaryTitle())) {
                String names = voucherDetails.getAuxiliaryTitle().substring(1, voucherDetails.getAuxiliaryTitle().length());
                String[] replaceName = names.split("_");
                String[] replaceId = voucherDetails.getSubjectCode().replace(subject.getCode(), "").replace("", "").split("_");
                List<String> codes = new ArrayList();
                for (int i = 0; i < replaceId.length; i++) {
                    if (StringUtils.isNotEmpty(replaceId[i])) {
                        AccountingCategoryDetails categoryDetails = accountingCategoryDetailsService.getById(Integer.parseInt(replaceId[i]));
                        codes.add(categoryDetails.getCode());
                    }
                }
                vo.setAccountingCategoryDetailsName(String.join("/", replaceName));
                vo.setAccountingCategoryDetailsCode(String.join("/", codes));
            }
            vo.setParentId(subject.getParentId());

            //上级合计
            setParentData(vo, subject.getId(), result);
            vo.setCode(subject.getCode());
            vo.setName(subject.getName() + voucherDetails.getAuxiliaryTitle());
            vo.setBalanceDirection(subject.getBalanceDirection());
            vo.setUnit(subject.getUnit());
            vo.setIsAccounting("是");
            result.put(Integer.parseInt(voucherDetails.getSubjectId() + "" + voucherDetails.getId()), vo);
        });
        return result.values().stream().sorted(Comparator.comparing(Subject::getCode)).collect(Collectors.toList());
    }

    private void setParentData(InitialBalanceVo vo, Integer parentId, Map<Integer, InitialBalanceVo> result) {
        log.info("parentId:{}", parentId);
        if (parentId != 0) {
            InitialBalanceVo initialBalanceVo = result.get(parentId);
            if (initialBalanceVo == null) {
                return;
            }
            initialBalanceVo.setBeginBalance(Optional.ofNullable(initialBalanceVo.getBeginBalance()).orElse(0d) + Optional.ofNullable(vo.getBeginBalance()).orElse(0d));
            initialBalanceVo.setCreditAccumulation(Optional.ofNullable(initialBalanceVo.getCreditAccumulation()).orElse(0d) + Optional.ofNullable(vo.getCreditAccumulation()).orElse(0d));
            initialBalanceVo.setNum(Optional.ofNullable(initialBalanceVo.getNum()).orElse(0d) + Optional.ofNullable(vo.getNum()).orElse(0d));
            initialBalanceVo.setCumulativeCredit(Optional.ofNullable(initialBalanceVo.getCumulativeCredit()).orElse(0d) + Optional.ofNullable(vo.getCumulativeCredit()).orElse(0d));
            initialBalanceVo.setCumulativeCreditNum(Optional.ofNullable(initialBalanceVo.getCumulativeCreditNum()).orElse(0d) + Optional.ofNullable(vo.getCumulativeCreditNum()).orElse(0d));
            initialBalanceVo.setCumulativeDebit(Optional.ofNullable(initialBalanceVo.getCumulativeDebit()).orElse(0d) + Optional.ofNullable(vo.getCumulativeDebit()).orElse(0d));
            initialBalanceVo.setCumulativeDebitNum(Optional.ofNullable(initialBalanceVo.getCumulativeDebitNum()).orElse(0d) + Optional.ofNullable(vo.getCumulativeDebitNum()).orElse(0d));
            initialBalanceVo.setYearBalance(Optional.ofNullable(initialBalanceVo.getYearBalance()).orElse(0d) + Optional.ofNullable(vo.getYearBalance()).orElse(0d));
            initialBalanceVo.setYearBalanceNum(Optional.ofNullable(initialBalanceVo.getYearBalanceNum()).orElse(0d) + Optional.ofNullable(vo.getYearBalanceNum()).orElse(0d));
            if (initialBalanceVo.getParentId() == 0) {
                return;
            } else {
                setParentData(initialBalanceVo, initialBalanceVo.getParentId(), result);
            }
        }
    }

}
