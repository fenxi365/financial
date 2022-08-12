package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

@Data
@TableName(value = "fxy_financial_voucher_word")
public class VoucherWord implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 凭证字
     */
    @TableField(value = "word")
    private String word;

    /**
     * 打印标题
     */
    @TableField(value = "print_title")
    private String printTitle;

    /**
     * 是否默认
     */
    @TableField(value = "is_default")
    private Boolean isDefault;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    private static final long serialVersionUID = 1L;

    public static final String COL_WORD = "word";

    public static final String COL_PRINT_TITLE = "print_title";

    public static final String COL_IS_DEFAULT = "is_default";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";
}