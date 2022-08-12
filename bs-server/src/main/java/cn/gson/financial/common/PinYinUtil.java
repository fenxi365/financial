package cn.gson.financial.common;

import cn.gson.financial.kernel.exception.ServiceException;
import lombok.extern.slf4j.Slf4j;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.common</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月18日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
public class PinYinUtil {
    /**
     * 将文字转为汉语拼音
     *
     * @param chineseLanguage
     * @return
     */
    public String toPinyin(String chineseLanguage) {
        char[] cl_chars = chineseLanguage.trim().toCharArray();
        StringBuilder pinyin = new StringBuilder();
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        // 输出拼音全部小写
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        // 不带声调
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        defaultFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
        try {
            for (char cl_char : cl_chars) {
                if (String.valueOf(cl_char).matches("[\u4e00-\u9fa5]+")) {
                    // 如果字符是中文,则将中文转为汉语拼音
                    pinyin.append(PinyinHelper.toHanyuPinyinStringArray(cl_char, defaultFormat)[0]);
                } else {
                    // 如果字符不是中文,则不转换
                    pinyin.append(cl_char);
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            log.error(chineseLanguage + "转拼音失败！", e);
            throw new ServiceException(chineseLanguage + "转拼音失败！", e);
        }
        return pinyin.toString();
    }

    public static String getFirstLettersUp(String ChineseLanguage) {
        return getFirstLetters(ChineseLanguage, HanyuPinyinCaseType.UPPERCASE);
    }

    public static String getFirstLettersLo(String ChineseLanguage) {
        return getFirstLetters(ChineseLanguage, HanyuPinyinCaseType.LOWERCASE);
    }

    public static String getFirstLetters(String chineseLanguage, HanyuPinyinCaseType caseType) {
        char[] cl_chars = chineseLanguage.trim().toCharArray();
        StringBuilder pinyin = new StringBuilder();
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        // 输出拼音全部大写
        defaultFormat.setCaseType(caseType);
        // 不带声调
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        try {
            for (char cl_char : cl_chars) {
                String str = String.valueOf(cl_char);
                if (str.matches("[\u4e00-\u9fa5]+")) {
                    // 如果字符是中文,则将中文转为汉语拼音,并取第一个字母
                    pinyin.append(PinyinHelper.toHanyuPinyinStringArray(cl_char, defaultFormat)[0].substring(0, 1));
                } else if (str.matches("[0-9]+")) {
                    // 如果字符是数字,取数字
                    pinyin.append(cl_char);
                } else if (str.matches("[a-zA-Z]+")) {
                    // 如果字符是字母,取字母
                    pinyin.append(cl_char);
                } else {
                    // 否则不转换
                    //如果是标点符号的话，带着
                    pinyin.append(cl_char);
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            log.error(chineseLanguage + "转拼音失败！", e);
            throw new ServiceException(chineseLanguage + "转拼音失败！", e);
        }
        return pinyin.toString();
    }

    public static String getPinyinString(String chineseLanguage) {
        char[] cl_chars = chineseLanguage.trim().toCharArray();
        StringBuilder pinyin = new StringBuilder();
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        // 输出拼音全部大写
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        // 不带声调
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        try {
            for (char cl_char : cl_chars) {
                String str = String.valueOf(cl_char);
                if (str.matches("[\u4e00-\u9fa5]+")) {
                    // 如果字符是中文,则将中文转为汉语拼音,并取第一个字母
                    pinyin.append(PinyinHelper.toHanyuPinyinStringArray(cl_char, defaultFormat)[0]);
                } else if (str.matches("[0-9]+")) {
                    // 如果字符是数字,取数字
                    pinyin.append(cl_char);
                } else if (str.matches("[a-zA-Z]+")) {
                    // 如果字符是字母,取字母
                    pinyin.append(cl_char);
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            log.error(chineseLanguage + "转拼音失败！", e);
            throw new ServiceException(chineseLanguage + "转拼音失败！", e);
        }
        return pinyin.toString();
    }

    /**
     * 取第一个汉字的第一个字符
     *
     * @param chineseLanguage
     * @return
     */
    public static String getFirstLetter(String chineseLanguage) {
        char[] cl_chars = chineseLanguage.trim().toCharArray();
        String pinyin = "";
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        // 输出拼音全部大写
        defaultFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);
        // 不带声调
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        try {
            String str = String.valueOf(cl_chars[0]);
            if (str.matches("[\u4e00-\u9fa5]+")) {
                // 如果字符是中文,则将中文转为汉语拼音,并取第一个字母
                pinyin = PinyinHelper.toHanyuPinyinStringArray(cl_chars[0], defaultFormat)[0].substring(0, 1);
            } else if (str.matches("[0-9]+")) {
                // 如果字符是数字,取数字
                pinyin += cl_chars[0];
            } else if (str.matches("[a-zA-Z]+")) {
                // 如果字符是字母,取字母
                pinyin += cl_chars[0];
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            log.error(chineseLanguage + "转拼音失败！", e);
            throw new ServiceException(chineseLanguage + "转拼音失败！", e);
        }
        return pinyin;
    }
}
