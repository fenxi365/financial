package cn.gson.financial.common;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
public class PdfFontUtils {

    /**
     * 字体
     */
    private static BaseFont baseFont = null;

    static {
        try {
            baseFont = BaseFont.createFont("simsun.ttc,1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        } catch (DocumentException e) {
            log.error("字体初始化失败！", e);
        } catch (IOException e) {
            log.error("simsun.ttc字体不存在！", e);
        }
    }

    /**
     * 文档超级  排版
     *
     * @param type 1-标题 2-标题一  3-标题二 4-标题三  5-正文  6-左对齐
     */
    public static Paragraph getFont(int type, String text) {
        Font font = new Font(baseFont);
        if (1 == type) {//1-标题
            font.setSize(16f);
            font.setStyle(Font.BOLD);
        } else if (2 == type) {//2-标题一
            font.setSize(16f);
            font.setStyle(Font.BOLD);
        } else if (3 == type) {//3-标题二
            font.setSize(14f);
            font.setStyle(Font.BOLD);
        } else if (4 == type) {//4-标题三
            font.setSize(14f);
        } else if (5 == type) {//5-正文
            font.setSize(10.5f);
        } else if (6 == type) {//6-左对齐
            font.setSize(8.5f);
        } else {
            font.setSize(8.5f);//默认大小
        }
        //注： 字体必须和 文字一起new
        Paragraph paragraph = new Paragraph(text, font);
        if (1 == type) {
            paragraph.setAlignment(Paragraph.ALIGN_CENTER);//居中
            paragraph.setSpacingBefore(10f);//上间距
            paragraph.setSpacingAfter(10f);//下间距
        } else if (2 == type) {//2-标题一
            paragraph.setAlignment(Element.ALIGN_JUSTIFIED); //默认
            paragraph.setSpacingBefore(2f);//上间距
            paragraph.setSpacingAfter(2f);//下间距
        } else if (3 == type) {
            paragraph.setSpacingBefore(2f);//上间距
            paragraph.setSpacingAfter(1f);//下间距
        } else if (4 == type) {//4-标题三
            //paragraph.setAlignment(Element.ALIGN_RIGHT);//右对齐
            paragraph.setSpacingBefore(2f);//上间距
            paragraph.setSpacingAfter(2f);//下间距
        } else if (5 == type) {
            paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
            paragraph.setFirstLineIndent(24);//首行缩进
            paragraph.setSpacingBefore(1f);//上间距
            paragraph.setSpacingAfter(1f);//下间距
        } else if (6 == type) {//左对齐
            paragraph.setAlignment(Element.ALIGN_LEFT);
            paragraph.setSpacingBefore(1f);//上间距
            paragraph.setSpacingAfter(1f);//下间距
        }
        return paragraph;
    }

    /**
     * 添加 cell
     *
     * @param table
     * @param text
     * @param colspan
     * @param border
     */
    public static void addCell(PdfPTable table, int align, String text, int colspan, int border) {
        PdfPCell cell = new PdfPCell(new Phrase(PdfFontUtils.getFont(6, text)));
        cell.setHorizontalAlignment(align);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setFixedHeight(30);
        cell.setColspan(colspan);
        cell.setBorder(border);
        //cell.setPaddingTop(10);
        //cell.setPaddingBottom(10);
        table.addCell(cell);
    }

    public static void addCell(PdfPTable table, String text, int colspan, int border) {
        addCell(table, Element.ALIGN_LEFT, text, colspan, border);
    }
}
