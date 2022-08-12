package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.entity</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月16日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_voucher_template_details")
public class VoucherTemplateDetails implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "voucher_template_id")
    private Integer voucherTemplateId;

    /**
     * 摘要
     */
    @TableField(value = "summary")
    private String summary;

    @TableField(value = "subject_id")
    private Integer subjectId;

    /**
     * 科目名称
     */
    @TableField(value = "subject_name")
    private String subjectName;

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

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    @TableField(value = "subject_code")
    private String subjectCode;

    @TableField(value = "auxiliary_title")
    private String auxiliaryTitle;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_VOUCHER_TEMPLATE_ID = "voucher_template_id";

    public static final String COL_SUMMARY = "summary";

    public static final String COL_SUBJECT_ID = "subject_id";

    public static final String COL_SUBJECT_NAME = "subject_name";

    public static final String COL_DEBIT_AMOUNT = "debit_amount";

    public static final String COL_CREDIT_AMOUNT = "credit_amount";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_SUBJECT_CODE = "subject_code";

    public static final String COL_AUXILIARY_TITLE = "auxiliary_title";
}