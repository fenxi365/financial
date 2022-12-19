package cn.gson.financial.controller;

import cn.gson.financial.base.BaseController;
import cn.gson.financial.common.ConvertMoney;
import cn.gson.financial.common.PdfFontUtils;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.User;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.service.AccountSetsService;
import cn.gson.financial.kernel.service.UserService;
import cn.gson.financial.kernel.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月12日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Controller
@RequestMapping("/pfd")
public class PrintPdfController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private AccountSetsService accountSetsService;

    @Autowired
    private VoucherService voucherService;

    private DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

    private DecimalFormat decf = new DecimalFormat("#,##0.00");

    @GetMapping("voucher")
    public ResponseEntity<byte[]> print(Integer[] id, Integer year, Integer month) throws IOException, DocumentException {

        String folder = System.getProperty("java.io.tmpdir");
        String tempPath = folder + UUID.randomUUID();

        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        if (year != null && month != null) {
            qw.eq(Voucher::getVoucherYear, year);
            qw.eq(Voucher::getVoucherMonth, month);
        } else {
            qw.in(Voucher::getId, Arrays.asList(id));
        }

        qw.eq(Voucher::getAccountSetsId, this.accountSetsId);
        List<Voucher> vouchers = voucherService.list(qw);
        Rectangle rect = new Rectangle(PageSize.A4);
        Document doc = new Document(rect);
        PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream(tempPath));
        writer.setPdfVersion(PdfWriter.PDF_VERSION_1_2);
        doc.addTitle("记账凭证");
        doc.addAuthor(this.currentUser.getAccountSets().getCompanyName());
        doc.addSubject("wmails@126.com");
        doc.addKeywords("记账凭证");
        doc.addCreator(this.currentUser.getRealName());
        doc.open();
        AtomicReference<Integer> totalItem = new AtomicReference<>(1);
        for (Voucher data : vouchers) {
            User createMember = userService.getById(data.getCreateMember());
            AccountSets accountSets = accountSetsService.getById(data.getAccountSetsId());

            double debitAmount = 0d;
            double creditAmount = 0d;
            for (VoucherDetails vd : data.getDetails()) {
                debitAmount += DoubleValueUtil.getNotNullVal(vd.getDebitAmount());
                creditAmount += DoubleValueUtil.getNotNullVal(vd.getCreditAmount());
            }

            outPage(data, createMember, accountSets, doc, 1, debitAmount, creditAmount, totalItem);
        }

        doc.close();
        HttpHeaders httpHeaders = new HttpHeaders();
        String fileName = "记账凭证.pdf";
        httpHeaders.setContentType(MediaType.APPLICATION_PDF);
        httpHeaders.set("X-UA-Compatible", "IE=Edge");
        httpHeaders.set(HttpHeaders.CONTENT_DISPOSITION, "inline;filename=" + java.net.URLEncoder.encode(fileName, "UTF-8"));
        return new ResponseEntity<>(FileUtils.readFileToByteArray(new File(tempPath)),
                httpHeaders,
                HttpStatus.OK);
    }

    private void outPage(Voucher data, User createMember, AccountSets accountSets, Document doc, int page, double debitAmount, double creditAmount, AtomicReference<Integer> totalItem) throws DocumentException {
        double pages = Math.ceil(data.getDetails().size() / 5d);

        String pageInfo = "";
        if (pages > 1) {
            pageInfo = "(" + page + "/" + (int) pages + ")";
        }

        doc.add(PdfFontUtils.getFont(1, "记账凭证"));
        float[] widths = {130, 150, 100, 100};
        PdfPTable table = new PdfPTable(widths);
        table.setLockedWidth(true);
        table.setTotalWidth(480);

        PdfFontUtils.addCell(table, "单位：" + accountSets.getCompanyName(), 2, PdfPCell.NO_BORDER);
        PdfFontUtils.addCell(table, "日期：" + df.format(data.getVoucherDate()), 1, PdfPCell.NO_BORDER);
        PdfFontUtils.addCell(table, "凭证号：" + data.getWord() + "-" + data.getCode() + pageInfo, 1, PdfPCell.NO_BORDER);

        PdfFontUtils.addCell(table, Element.ALIGN_CENTER, "摘要", 1, PdfPCell.BOX);
        PdfFontUtils.addCell(table, Element.ALIGN_CENTER, "科目", 1, PdfPCell.BOX);
        PdfFontUtils.addCell(table, Element.ALIGN_CENTER, "借方金额", 1, PdfPCell.BOX);
        PdfFontUtils.addCell(table, Element.ALIGN_CENTER, "贷方金额", 1, PdfPCell.BOX);
        int start = (page - 1) * 5;
        int end = start + 5;
        for (int i = start; i < end; i++) {
            VoucherDetails vd = i < data.getDetails().size() ? data.getDetails().get(i) : null;
            PdfFontUtils.addCell(table, vd != null ? vd.getSummary() : " ", 1, PdfPCell.BOX);
            PdfFontUtils.addCell(table, vd != null ? (vd.getSubjectName() + (vd.getAuxiliaryTitle() == null ? "" : vd.getAuxiliaryTitle())) : " ", 1, PdfPCell.BOX);
            PdfFontUtils.addCell(table, Element.ALIGN_RIGHT, vd != null ? (vd.getDebitAmount() != null ? decf.format(vd.getDebitAmount()) : "") : " ", 1, PdfPCell.BOX);
            PdfFontUtils.addCell(table, Element.ALIGN_RIGHT, vd != null ? (vd.getCreditAmount() != null ? decf.format(vd.getCreditAmount()) : "") : " ", 1, PdfPCell.BOX);
        }

        PdfFontUtils.addCell(table, "合计：" + ConvertMoney.convert(debitAmount), 2, PdfPCell.BOX);
        PdfFontUtils.addCell(table, Element.ALIGN_RIGHT, decf.format(debitAmount), 1, PdfPCell.BOX);
        PdfFontUtils.addCell(table, Element.ALIGN_RIGHT, decf.format(creditAmount), 1, PdfPCell.BOX);

        PdfFontUtils.addCell(table, "主管：无", 1, PdfPCell.NO_BORDER);
        PdfFontUtils.addCell(table, "出纳：无", 1, PdfPCell.NO_BORDER);
        PdfFontUtils.addCell(table, "制单人：" + createMember.getRealName(), 1, PdfPCell.NO_BORDER);
        PdfFontUtils.addCell(table, "审核人：无", 1, PdfPCell.NO_BORDER);


        doc.add(table);

        if (totalItem.get() % 2 != 0) {
            doc.add(PdfFontUtils.getFont(1, "     "));
            doc.add(PdfFontUtils.getFont(1, "—-                                                         —-"));
            doc.add(PdfFontUtils.getFont(1, "     "));
        }

        totalItem.set(totalItem.get() + 1);

        if (pages > 1 && pages != page) {
            outPage(data, createMember, accountSets, doc, page + 1, debitAmount, creditAmount, totalItem);
        }
    }
}
