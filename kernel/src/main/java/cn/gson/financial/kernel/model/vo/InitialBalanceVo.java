package cn.gson.financial.kernel.model.vo;

import cn.gson.financial.kernel.model.entity.Subject;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.pojo</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月06日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class InitialBalanceVo extends Subject {

    private Integer subjectId;

    private Integer balanceId;

    private Double beginBalance;

    private Double debitAccumulation;

    private Double creditAccumulation;

    private Double initialBalance;

    private Double num;
    /**
     * 期初累计借方
     */
    private Double cumulativeDebit;

    /**
     * 期初累计贷方
     */
    private Double cumulativeCredit;

    private Double cumulativeDebitNum;

    private Double cumulativeCreditNum;

    private boolean leaf;

    private String  isAccounting;

    //年初
    private Double yearBalance;

    private Double yearBalanceNum;
    //辅助类别
//    private String accountingCategory;
    //辅助核算编码 /
    private String accountingCategoryDetailsCode;
    //辅助核算名称 /
    private String accountingCategoryDetailsName;

    private List<InitialBalanceVo> children;

}
