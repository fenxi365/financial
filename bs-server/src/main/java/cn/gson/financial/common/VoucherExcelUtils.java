package cn.gson.financial.common;

import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.*;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.AccountingCategoryDetailsService;
import cn.gson.financial.kernel.service.AccountingCategoryService;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherDetailsAuxiliaryService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.common</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月15日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Component
public final class VoucherExcelUtils {
    private String[] COLS = {};
    //辅助项目
    private String[] AUXILIARY = {};

    private Map<Integer, AccountingCategory> ACCOUNTINGCATEGORY = new LinkedHashMap<>();

    private DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    private SubjectService subjectService;

    @Autowired
    private AccountingCategoryDetailsService acds;

    @Autowired
    private AccountingCategoryService accountingCategoryService;

    @Autowired
    private VoucherDetailsAuxiliaryService voucherDetailsAuxiliaryService;


    public void exportExcel(List<Voucher> list, UserVo userVo, HttpServletResponse response) throws IOException {
        this.loadCategory(userVo);
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("凭证信息");// 工作表对象
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < COLS.length; i++) {
            HSSFCell codeCell = row.createCell(i);
            codeCell.setCellValue(COLS[i]);
            codeCell.setCellType(CellType.STRING);
        }
        AtomicInteger index = new AtomicInteger(1);

        for (int i = 0; i < list.size(); i++) {
            Voucher voucher = list.get(i);
            //                  0   1   2   3       4       5       6       7       8       9      10   11
            // String cols = "日期,凭证号,摘要,科目编码,科目名称,外币代码,借方数量,借方外币,借方本币,贷方数量,贷方外币,贷方本币,
            // " + 供应商 StringUtils.join(names, ",") + ",制单人,审核人,附件数,备注";
            voucher.getDetails().forEach(d -> {
                HSSFRow dtRow = sheet.createRow(index.get());
                dtRow.createCell(0).setCellValue(DateFormatUtils.format(voucher.getVoucherDate(), "yyyy-MM-dd"));
                dtRow.createCell(1).setCellValue(voucher.getWord() + "-" + voucher.getCode());
                dtRow.createCell(2).setCellValue(d.getSummary());
                dtRow.createCell(3).setCellValue(d.getSubjectCode());
                dtRow.createCell(4).setCellValue(d.getSubjectName());
                dtRow.createCell(5).setCellValue("");
                if (d.getDebitAmount() != null && d.getDebitAmount() > 0 && d.getNum() != null) {
                    dtRow.createCell(6).setCellValue(d.getNum());
                } else {
                    dtRow.createCell(6).setCellValue("");
                }
                dtRow.createCell(7).setCellValue("");
                if (d.getDebitAmount() != null) {
                    dtRow.createCell(8).setCellValue(d.getDebitAmount()); //借方
                } else {
                    dtRow.createCell(8).setCellValue("");
                }
                if (d.getCreditAmount() != null && d.getCreditAmount() > 0 && d.getNum() != null) {
                    dtRow.createCell(9).setCellValue(d.getNum());
                } else {
                    dtRow.createCell(9).setCellValue("");
                }
                dtRow.createCell(10).setCellValue("");
                if (d.getCreditAmount() != null) {
                    dtRow.createCell(11).setCellValue(d.getCreditAmount());
                } else {
                    dtRow.createCell(11).setCellValue("");
                }
                if (StringUtils.isNotEmpty(d.getAuxiliaryTitle())) {
                    Map<String, String> auxiliaryMap = new HashMap<>(AUXILIARY.length);
                    List<VoucherDetailsAuxiliary> voucherDetailsAuxiliaries = voucherDetailsAuxiliaryService.selectByDetailsId(d.getId());
                    voucherDetailsAuxiliaries.forEach(voucherDetailsAuxiliary -> {
                        AccountingCategory accountingCategory = ACCOUNTINGCATEGORY.get(voucherDetailsAuxiliary.getAccountingCategoryId());
                        auxiliaryMap.put(accountingCategory.getName() + "编码", voucherDetailsAuxiliary.getAccountingCategoryDetails().getCode());
                        auxiliaryMap.put(accountingCategory.getName() + "名称", voucherDetailsAuxiliary.getAccountingCategoryDetails().getName());
                    });
                    for (int j = 0; j < AUXILIARY.length; j++) {
                        dtRow.createCell((12 + j)).setCellValue(auxiliaryMap.get(AUXILIARY[j]));
                    }
                } else {
                    for (int j = 0; j < AUXILIARY.length; j++) {
                        dtRow.createCell((12 + j)).setCellValue("");
                    }
                }

                dtRow.createCell((12 + AUXILIARY.length)).setCellValue(userVo.getNickname());
                dtRow.createCell((13 + AUXILIARY.length)).setCellValue(voucher.getAuditMemberName());
                dtRow.createCell((14 + AUXILIARY.length)).setCellValue(voucher.getReceiptNum() > 0 ? voucher.getReceiptNum() + "" : "");
                dtRow.createCell((15 + AUXILIARY.length)).setCellValue(voucher.getRemark());
                index.getAndIncrement();
            });
        }
        String fileName = "凭证信息.xls";
        response.setContentType("application/vnd.ms-excel;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
        workbook.write(response.getOutputStream());
        workbook.close();
    }

    /**
     * 读取excel数据并转化
     *
     * @param fileName
     * @param is
     * @param userVo
     * @return
     * @throws IOException
     */
    public List<Voucher> readExcel(String fileName, InputStream is, UserVo userVo,Integer orgId) throws IOException {
        this.loadCategory(userVo);

        List<Voucher> list = new ArrayList<>();
        Workbook workbook;
        if ("xls".equals(FilenameUtils.getExtension(fileName))) {
            workbook = new HSSFWorkbook(is);
        } else {
            workbook = new XSSFWorkbook(is);
        }
        Sheet sheet = workbook.getSheetAt(0);
        if (sheet != null) {
            //检查excel格式
            this.checkHeader(sheet);

            List<Map<String, Object>> data = new ArrayList<>(sheet.getLastRowNum());
            //所有编码类项目
            Set<String> subjectCodeSet = new HashSet<>();
            Map<String, Set<String>> auxiliaryMap = new HashMap<>(AUXILIARY.length);

            for (int i = 1, len = sheet.getLastRowNum(); i <= len; i++) {
                Row row = sheet.getRow(i);
                Map<String, Object> rowData = new HashMap<>(row.getLastCellNum());
                //根据表头遍历数据
                for (int j = 0; j < COLS.length; j++) {
                    Cell cell = row.getCell(j);
                    String key = COLS[j];
                    Object val;
                    try {
                        switch (cell.getCellType()) {
                            case NUMERIC:
                                if (DateUtil.isCellDateFormatted(cell)) {
                                    val = DateFormatUtils.format(cell.getDateCellValue(), "yyyy-MM-dd");
                                } else {
                                    val = cell.getNumericCellValue();
                                }
                                break;
                            default:
                                val = cell.getStringCellValue();
                                break;
                        }

                        if (key.equals("科目编码") && val instanceof Double) {
                            val = ((Double) val).intValue();
                        }
                        rowData.put(key, val);
                    } catch (Exception e) {
                        throw new ServiceException("[" + key + "]列读取错误！" + e.getMessage(), e);
                    }
                }

                subjectCodeSet.add(rowData.get("科目编码").toString());

                //汇总辅助项
                for (String a : AUXILIARY) {
                    if (!auxiliaryMap.containsKey(a)) {
                        auxiliaryMap.put(a, new HashSet<>());
                    }
                    Object val = rowData.get(a + "编码");
                    if (val != null && StringUtils.trimToNull(val.toString()) != null) {
                        auxiliaryMap.get(a).add(StringUtils.trim(val.toString()));
                    }
                }

                rowData.put("unix", StringUtils.join(rowData.get("日期"), "~", rowData.get("凭证号"), "~", rowData.get("备注")));
                data.add(rowData);
            }


            //科目数据
            Map<String, Subject> codeList = this.getByCodeList(userVo.getAccountSetsId(), subjectCodeSet);
            //辅助项目数据
            Map<String, Map<String, AccountingCategoryDetails>> auxiliaryDataMap = this.getAuxiliaryDataMap(userVo.getAccountSetsId(), auxiliaryMap);

            Map<String, List<Map<String, Object>>> unix = data.stream().collect(Collectors.groupingBy(map -> map.get("unix").toString()));

            unix.forEach((key, maps) -> {
                String[] split = StringUtils.split(key, "~");
                Calendar calendar;
                try {
                    calendar = DateUtils.toCalendar(df.parse(split[0]));
                } catch (ParseException e) {
                    throw new ServiceException("日期[" + split[0] + "]格式错误,请设置日期列单元格格式为‘文本’类型！", e);
                }
                String[] wordCode = StringUtils.split(split[1], "-");

                Voucher voucher = new Voucher();
                voucher.setWord(wordCode[0]);
                voucher.setCode(Integer.parseInt(wordCode[1]));
                if (split.length > 2) {
                    voucher.setRemark(split[2]);
                }
                voucher.setCreateDate(calendar.getTime());
                voucher.setVoucherYear(calendar.get(Calendar.YEAR));
                voucher.setVoucherMonth(calendar.get(Calendar.MONTH) + 1);
                voucher.setVoucherDate(calendar.getTime());
                voucher.setDetails(new ArrayList<>(maps.size()));
                voucher.setCreateMember(userVo.getId());
                voucher.setAccountSetsId(userVo.getAccountSetsId());
                voucher.setCarryForward(false);
                voucher.setOrgId(orgId);
                maps.forEach(map -> {
                    VoucherDetails details = new VoucherDetails();
                    JSONObject jo = new JSONObject(map);
                    details.setSummary(jo.getString("摘要"));
                    details.setSubjectName(jo.getString("科目名称"));
                    details.setSubjectCode(jo.getString("科目编码"));
                    details.setDebitAmount(jo.getDouble("借方本币"));
                    details.setCreditAmount(jo.getDouble("贷方本币"));
                    details.setAccountSetsId(userVo.getAccountSetsId());
                    details.setOrgId(orgId);
                    details.setAuxiliary(new ArrayList<>());
                    details.setCarryForward(false);
                    details.setNum(DoubleValueUtil.getNotNullVal(jo.getDouble("借方数量"), jo.getDouble("贷方数量")));

                    if (StringUtils.trim(details.getSummary()).endsWith("结转损益")) {
                        details.setCarryForward(true);
                        voucher.setCarryForward(true);
                    }

                    //处理科目ID
                    if (!codeList.containsKey(details.getSubjectCode())) {
                        throw new ServiceException("科目编码：" + details.getSubjectCode() + ",没有在账套中定义。");
                    }
                    details.setSubjectId(codeList.get(details.getSubjectCode()).getId());

                    //处理辅助项目
                    for (String a : AUXILIARY) {
                        String val = jo.getString(a + "编码");
                        if (StringUtils.isNotEmpty(val)) {
                            if (!auxiliaryDataMap.get(a).containsKey(val)) {
                                throw new ServiceException(a + "辅助编码：" + val + ",没有在账套辅助项中定义。");
                            }
                            details.getAuxiliary().add(auxiliaryDataMap.get(a).get(val));
                        }
                    }

                    //处理名称
                    if (details.getAuxiliary().size() > 0) {
                        StringBuffer codeTitle = new StringBuffer(details.getSubjectCode());
                        StringBuffer nameTitle = new StringBuffer(details.getSubjectName());
                        StringBuffer auxiliaryTitle = new StringBuffer();

                        details.getAuxiliary().forEach(d -> {
                            codeTitle.append("_").append(d.getId());
                            nameTitle.append("_").append(d.getName());
                            auxiliaryTitle.append("_").append(d.getName());
                        });
                        details.setSubjectName(codeTitle.append("-").append(nameTitle).toString());
                        details.setAuxiliaryTitle(auxiliaryTitle.toString());
                    } else {
                        details.setSubjectName(details.getSubjectCode() + "-" + details.getSubjectName());
                    }

                    //details.setPrice();
                    voucher.getDetails().add(details);
                });

                list.add(voucher);
            });
        }

        log.info("data:{}", JSONObject.toJSONString(list));

        return list;
    }

    /**
     * 加载辅助字段
     *
     * @param userVo
     */
    private void loadCategory(UserVo userVo) {
        LambdaQueryWrapper<AccountingCategory> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategory::getAccountSetsId, userVo.getAccountSets().getId());
        List<AccountingCategory> list = this.accountingCategoryService.list(qw);
        List<String> names = new ArrayList<>();
        for (AccountingCategory accountingCategory : list) {
            names.add(accountingCategory.getName() + "编码");
            names.add(accountingCategory.getName() + "名称");
        }
        this.AUXILIARY = names.toArray(new String[0]);
        this.ACCOUNTINGCATEGORY = list.stream().collect(Collectors.toMap(accountingCategory -> accountingCategory.getId(), s -> s));
        String cols = "日期,凭证号,摘要,科目编码,科目名称,外币代码,借方数量,借方外币,借方本币,贷方数量,贷方外币,贷方本币," + StringUtils.join(names, ",") + ",制单人,审核人,附件数,备注";
        this.COLS = cols.split(",");
    }

    private Map<String, Map<String, AccountingCategoryDetails>> getAuxiliaryDataMap(Integer accountSetsId, Map<String, Set<String>> auxiliaryMap) {
        Map<String, Map<String, AccountingCategoryDetails>> data = new HashMap<>(auxiliaryMap.size());

        for (Map.Entry<String, Set<String>> entry : auxiliaryMap.entrySet()) {
            if (entry.getValue().size() > 0) {
                List<AccountingCategoryDetails> details = acds.getByCodeSet(entry.getKey(), accountSetsId, entry.getValue());
                Map<String, AccountingCategoryDetails> map = details.stream().collect(Collectors.toMap(AccountingCategoryDetails::getCode, s -> s));
                data.put(entry.getKey(), map);
            }
        }

        return data;
    }

    private Map<String, Subject> getByCodeList(Integer accountSetsId, Set<String> subjectCodeSet) {
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.eq(Subject::getAccountSetsId, accountSetsId);
        qw.in(Subject::getCode, subjectCodeSet);

        List<Subject> list = this.subjectService.list(qw);
        return list.stream().collect(Collectors.toMap(Subject::getCode, subject -> subject));
    }

    /**
     * 表头检查，不符合表头，不允许导入
     *
     * @param sheet
     */
    private void checkHeader(Sheet sheet) {
        Row row = sheet.getRow(0);
        for (int i = 0; i < COLS.length; i++) {
            String col = COLS[i];
            Cell cell = row.getCell(i);
            if (!col.equalsIgnoreCase(cell.getStringCellValue())) {
                throw new ServiceException("[" + col + "]位置表头错误！表头正确顺序:%s", StringUtils.join(COLS, ","));
            }
        }
    }
}
