package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
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
@TableName(value = "fxy_financial_voucher")
public class Voucher implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 凭证字
     */
    @TableField(value = "word")
    private String word;

    @TableField(value = "code")
    private Integer code;

    /**
     * 备注
     */
    @TableField(value = "remark")
    private String remark;

    /**
     * 附单据数量
     */
    @TableField(value = "receipt_num")
    private Integer receiptNum;

    /**
     * 制单人
     */
    @TableField(value = "create_member")
    private Integer createMember;

    @TableField(value = "create_date")
    private Date createDate;

    /**
     * 借方总金额
     */
    @TableField(value = "debit_amount")
    private Double debitAmount;

    /**
     * 贷方总金额
     */
    @TableField(value = "credit_amount")
    private Double creditAmount;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    @TableField(value = "voucher_year")
    private Integer voucherYear;

    @TableField(value = "voucher_month")
    private Integer voucherMonth;

    @TableField(value = "voucher_date")
    private Date voucherDate;

    /**
     * 审核人 ID
     */
    @TableField(value = "audit_member_id")
    private Integer auditMemberId;

    /**
     * 审核人姓名
     */
    @TableField(value = "audit_member_name")
    private String auditMemberName;

    /**
     * 审核时间
     */
    @TableField(value = "audit_date")
    private Date auditDate;

    /**
     * 是否结转损益
     */
    @TableField(value = "carry_forward")
    private Boolean carryForward;

    @TableField(exist = false)
    private List<VoucherDetails> details = new ArrayList<>(0);

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_WORD = "word";

    public static final String COL_CODE = "code";

    public static final String COL_REMARK = "remark";

    public static final String COL_RECEIPT_NUM = "receipt_num";

    public static final String COL_CREATE_MEMBER = "create_member";

    public static final String COL_CREATE_DATE = "create_date";

    public static final String COL_DEBIT_AMOUNT = "debit_amount";

    public static final String COL_CREDIT_AMOUNT = "credit_amount";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_VOUCHER_YEAR = "voucher_year";

    public static final String COL_VOUCHER_MONTH = "voucher_month";

    public static final String COL_VOUCHER_DATE = "voucher_date";

    public static final String COL_AUDIT_MEMBER_ID = "audit_member_id";

    public static final String COL_AUDIT_MEMBER_NAME = "audit_member_name";

    public static final String COL_AUDIT_DATE = "audit_date";

    public static final String COL_CARRY_FORWARD = "carry_forward";
}