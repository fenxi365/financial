package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName(value = "fxy_financial_accounting_category")
public class AccountingCategory implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 辅助核算类别名称
     */
    @TableField(value = "name")
    private String name;

    @TableField(value = "custom_columns")
    private String customColumns;

    /**
     * 是否为系统默认
     */
    @TableField(value = "system_default")
    private Boolean systemDefault;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    @TableField(value = "can_edit")
    private Boolean canEdit;

    private static final long serialVersionUID = 1L;

    public static final String COL_NAME = "name";

    public static final String COL_CUSTOM_COLUMNS = "custom_columns";

    public static final String COL_SYSTEM_DEFAULT = "system_default";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_CAN_EDIT = "can_edit";
}