package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.AccountingCategory;
import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.service.AccountingCategoryDetailsService;
import cn.gson.financial.kernel.service.AccountingCategoryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@RestController
@RequestMapping("/accounting-category")
public class AccountingCategoryController extends BaseCrudController<AccountingCategoryService, AccountingCategory> {

    @Autowired
    private AccountingCategoryDetailsService detailsService;

    @GetMapping("template")
    public void downTemplate(@RequestParam Integer categoryId, HttpServletResponse response) throws IOException {
        LambdaQueryWrapper<AccountingCategory> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategory::getAccountSetsId, this.accountSetsId);
        qw.eq(AccountingCategory::getId, categoryId);
        AccountingCategory category = this.service.getOne(qw);
        String[] columns = (category.getName() + "编码," + category.getName() + "名称," + category.getCustomColumns() + ",备注").split(",");
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(category.getName() + "-" + category.getId());// 工作表对象
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < columns.length; i++) {
            HSSFCell codeCell = row.createCell(i);
            codeCell.setCellValue(columns[i]);
            codeCell.setCellType(CellType.STRING);
        }

        String fileName = category.getName() + "导入模板.xls";
        response.setContentType("application/vnd.ms-excel;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
        workbook.write(response.getOutputStream());
        workbook.close();
    }

    @GetMapping("download")
    public void downloadData(@RequestParam Integer categoryId, HttpServletResponse response) throws IOException {
        LambdaQueryWrapper<AccountingCategory> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategory::getAccountSetsId, this.accountSetsId);
        qw.eq(AccountingCategory::getId, categoryId);
        AccountingCategory category = this.service.getOne(qw);
        String[] columns = (category.getName() + "编码," + category.getName() + "名称," + category.getCustomColumns() + ",备注").split(",");
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(category.getName() + "-" + category.getId());// 工作表对象
        HSSFRow row = sheet.createRow(0);
        for (int i = 0; i < columns.length; i++) {
            HSSFCell codeCell = row.createCell(i);
            codeCell.setCellValue(columns[i]);
            codeCell.setCellType(CellType.STRING);
        }

        LambdaQueryWrapper<AccountingCategoryDetails> qwd = Wrappers.lambdaQuery();
        qwd.eq(AccountingCategoryDetails::getAccountingCategoryId, categoryId);
        qwd.orderByAsc(AccountingCategoryDetails::getCode);
        // 明细数据
        List<AccountingCategoryDetails> details = detailsService.list(qwd);

        for (int i = 0; i < details.size(); i++) {
            AccountingCategoryDetails d = details.get(i);
            HSSFRow dtRow = sheet.createRow(i + 1);
            dtRow.createCell(0).setCellValue(d.getCode());
            dtRow.createCell(1).setCellValue(d.getName());
            dtRow.createCell(columns.length - 1).setCellValue(d.getRemark());

            for (int j = 2; j < columns.length - 1; j++) {
                Method method = BeanUtils.findMethod(AccountingCategoryDetails.class, "getCusColumn" + (j - 2));
                if (method != null) {
                    try {
                        method.setAccessible(true);
                        String invoke = (String) method.invoke(d);
                        dtRow.createCell(j).setCellValue(invoke);
                    } catch (Exception e) {
                        log.error("辅助导出行数据读取失败", e);
                        throw new ServiceException("xls列" + columns[j] + "的数据写出失败，请检查数据！", e);
                    }
                }
            }
        }

        String fileName = category.getName() + "导出数据" + categoryId + ".xls";
        response.setContentType("application/vnd.ms-excel;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
        workbook.write(response.getOutputStream());
        workbook.close();
    }

    @PostMapping("import")
    public JsonResult importData(@RequestParam Integer categoryId, @RequestParam("file") MultipartFile multipartFile) throws IOException {
        LambdaQueryWrapper<AccountingCategory> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategory::getAccountSetsId, this.accountSetsId);
        qw.eq(AccountingCategory::getId, categoryId);
        AccountingCategory category = this.service.getOne(qw);
        if (category == null) {
            return JsonResult.failure("亲，导入类别选择错误~");
        }
        String[] columns = (category.getName() + "编码," + category.getName() + "名称," + category.getCustomColumns() + ",备注").split(",");

        Workbook workbook;

        try {
            workbook = new HSSFWorkbook(multipartFile.getInputStream());
        } catch (IOException e) {
            log.error("辅助导入上传文件异常", e);
            throw new ServiceException("文件读取失败，请重新上传！", e);
        }

        Sheet sheet = workbook.getSheetAt(0);
        this.checkHeader(sheet, columns);

        Map<String, AccountingCategoryDetails> detailsMap = new HashMap<>();

        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row row = sheet.getRow(i);
            AccountingCategoryDetails detail = new AccountingCategoryDetails();
            detail.setAccountingCategoryId(categoryId);
            detail.setEnable(true);
            detail.setCode(this.getCellVal(row.getCell(0)));
            detail.setName(this.getCellVal(row.getCell(1)));
            detail.setRemark(this.getCellVal(row.getCell(columns.length - 1)));

            for (int j = 2; j < columns.length - 1; j++) {
                Method method = BeanUtils.findMethod(AccountingCategoryDetails.class, "setCusColumn" + (j - 2), String.class);
                if (method != null) {
                    try {
                        method.setAccessible(true);
                        method.invoke(detail, this.getCellVal(row.getCell(j)));
                    } catch (Exception e) {
                        log.error("辅助导入行数据读取失败", e);
                        throw new ServiceException("xls列" + columns[j] + "的数据读取失败，请检查数据！", e);
                    }
                }
            }
            if (detailsMap.containsKey(detail.getCode())) {
                throw new ServiceException("亲，编码[" + detail.getCode() + "]重复,请检查编码~");
            }
            detailsMap.put(detail.getCode(), detail);
        }
        workbook.close();
        return JsonResult.successful(detailsService.importData(categoryId, detailsMap));
    }

    private String getCellVal(Cell cell) {
        String val = "";
        if (cell.getCellType() == CellType.NUMERIC) {
            if (DateUtil.isCellDateFormatted(cell)) {
                val = DateFormatUtils.format(cell.getDateCellValue(), "yyyy-MM-dd");
            } else {
                val = cell.getNumericCellValue() + "";
            }
        } else {
            val = cell.getStringCellValue();
        }
        return val;
    }


    /**
     * 表头检查，不符合表头，不允许导入
     *
     * @param sheet
     */
    private void checkHeader(Sheet sheet, String[] columns) {
        Row row = sheet.getRow(0);
        for (int i = 0; i < columns.length; i++) {
            String col = columns[i];
            Cell cell = row.getCell(i);
            if (!col.equalsIgnoreCase(cell.getStringCellValue())) {
                throw new ServiceException("表头错误！表头正确顺序：%s", StringUtils.join(columns, ","));
            }
        }
    }
}
