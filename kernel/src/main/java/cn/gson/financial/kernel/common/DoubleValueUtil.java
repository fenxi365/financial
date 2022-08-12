package cn.gson.financial.kernel.common;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.common</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月07日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public final class DoubleValueUtil {

    /**
     * 获取非空值
     *
     * @param val
     * @return
     */
    public static Double getNotNullVal(Double val) {
        return getNotNullVal(val, 0d);
    }

    /**
     * 获取非空值
     *
     * @param val
     * @param defaultVal 默认值
     * @return
     */
    public static Double getNotNullVal(Double val, Double defaultVal) {
        if (val == null) {
            return defaultVal == null ? 0 : defaultVal;
        }
        return val;
    }
}
