package cn.gson.financial.kernel.model.vo;

import lombok.Data;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.vo</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月08日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
public class ReportDataVo {

    /**
     * 模板项 ID
     */
    private Integer itemId;

    /**
     * 本年累计金额
     */
    private Double currentYearAmount;

    /**
     * 本期金额
     */
    private Double currentPeriodAmount;
}
