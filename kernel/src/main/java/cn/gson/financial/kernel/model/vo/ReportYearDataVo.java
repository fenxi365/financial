package cn.gson.financial.kernel.model.vo;

import lombok.Data;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/3/2 15:39</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
public class ReportYearDataVo {

    /**
     * 模板项 ID
     */
    private Integer itemId;

    /**
     * 本年累计金额
     */
    private Double currentYearAmount;

    /**
     * 一月
     */
    private Double januaryAmount;
    /**
     * 二月
     */
    private Double februaryAmount;
    /**
     * 三月
     */
    private Double marchAmount;
    /**
     * 四月
     */
    private Double aprilAmount;
    /**
     * 五月
     */
    private Double mayAmount;
    /**
     * 六月
     */
    private Double juneAmount;
    /**
     * 七月
     */
    private Double julyAmount;
    /**
     * 八月
     */
    private Double augustAmount;
    /**
     * 九月
     */
    private Double septemberAmount;
    /**
     * 十月
     */
    private Double octoberAmount;
    /**
     * 十一月
     */
    private Double novemberAmount;
    /**
     * 十二月
     */
    private Double decemberAmount;
}
