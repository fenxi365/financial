package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.entity</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月21日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_voucher_details")
public class VoucherDetails implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "voucher_id")
    private Integer voucherId;

    /**
     * 摘要
     */
    @TableField(value = "summary")
    private String summary;

    @TableField(value = "subject_id")
    private Integer subjectId;

    @TableField(value = "subject_name")
    private String subjectName;

    @TableField(value = "subject_code")
    private String subjectCode;

    /**
     * 借方金额
     */
    @TableField(value = "debit_amount")
    private Double debitAmount;

    /**
     * 贷方金额
     */
    @TableField(value = "credit_amount")
    private Double creditAmount;

    /**
     * 辅助名称
     */
    @TableField(value = "auxiliary_title")
    private String auxiliaryTitle;

    /**
     * 数量
     */
    @TableField(value = "num")
    private Double num;

    /**
     * 单价
     */
    @TableField(value = "price")
    private Double price;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;


    @TableField(value = "org_id")
    private Integer orgId;

    /**
     * 期初累计借方
     */
    @TableField(value = "cumulative_debit")
    private Double cumulativeDebit;

    /**
     * 期初累计贷方
     */
    @TableField(value = "cumulative_credit")
    private Double cumulativeCredit;

    @TableField(value = "cumulative_debit_num")
    private Double cumulativeDebitNum;

    @TableField(value = "cumulative_credit_num")
    private Double cumulativeCreditNum;

    /**
     * 结转损益
     */
    @TableField(value = "carry_forward")
    private Boolean carryForward;

    @TableField(exist = false)
    private List<AccountingCategoryDetails> auxiliary = new ArrayList<>(0);

    @TableField(exist = false)
    private Subject subject;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_VOUCHER_ID = "voucher_id";

    public static final String COL_SUMMARY = "summary";

    public static final String COL_SUBJECT_ID = "subject_id";

    public static final String COL_SUBJECT_NAME = "subject_name";

    public static final String COL_SUBJECT_CODE = "subject_code";

    public static final String COL_DEBIT_AMOUNT = "debit_amount";

    public static final String COL_CREDIT_AMOUNT = "credit_amount";

    public static final String COL_AUXILIARY_TITLE = "auxiliary_title";

    public static final String COL_NUM = "num";

    public static final String COL_PRICE = "price";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_CUMULATIVE_DEBIT = "cumulative_debit";

    public static final String COL_CUMULATIVE_CREDIT = "cumulative_credit";

    public static final String COL_CUMULATIVE_DEBIT_NUM = "cumulative_debit_num";

    public static final String COL_CUMULATIVE_CREDIT_NUM = "cumulative_credit_num";

    public static final String COL_CARRY_FORWARD = "carry_forward";
}