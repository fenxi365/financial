package cn.gson.financial.common;

import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/3/8 16:53</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Component
public class InitialExcelUtils {

    public  void  readExcel() throws IOException {
        InputStream excelInputStream = this.getClass().getResourceAsStream("/tpl/InitialBalance.xls");
        Workbook workbook = WorkbookFactory.create(excelInputStream);

    }

    public  void exportExcel() throws IOException {
        InputStream excelInputStream = this.getClass().getResourceAsStream("/tpl/InitialBalance.xls");
        HSSFWorkbook workbook = (HSSFWorkbook)WorkbookFactory.create(excelInputStream);
        HSSFSheet sheet = workbook.getSheetAt(0);//写入第一个
        HSSFRow row = sheet.createRow(0);

    }
}
