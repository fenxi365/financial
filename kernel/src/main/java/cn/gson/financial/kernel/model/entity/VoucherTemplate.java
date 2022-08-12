package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
@TableName(value = "fxy_financial_voucher_template")
public class VoucherTemplate implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 模板名称
     */
    @TableField(value = "name")
    private String name;

    @TableField(value = "is_default")
    private Boolean isDefault;

    @TableField(value = "type")
    private Byte type;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    @TableField(value = "debit_amount")
    private Double debitAmount;

    @TableField(value = "credit_amount")
    private Double creditAmount;

    @TableField(exist = false)
    private List<VoucherTemplateDetails> details;

    private static final long serialVersionUID = 1L;

    public static final String COL_NAME = "name";

    public static final String COL_IS_DEFAULT = "is_default";

    public static final String COL_TYPE = "type";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_DEBIT_AMOUNT = "debit_amount";

    public static final String COL_CREDIT_AMOUNT = "credit_amount";
}