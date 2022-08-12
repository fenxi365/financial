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
 * <li>Creation    : 2019年09月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_subject")
public class Subject implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 科目类型
     */
    @TableField(value = "type")
    private Object type;

    /**
     * 科目编码
     */
    @TableField(value = "code")
    private String code;

    /**
     * 科目名称
     */
    @TableField(value = "name")
    private String name;

    /**
     * 助记码
     */
    @TableField(value = "mnemonic_code")
    private String mnemonicCode;

    /**
     * 余额方向
     */
    @TableField(value = "balance_direction")
    private Object balanceDirection;

    /**
     * 状态
     */
    @TableField(value = "status")
    private Boolean status;

    /**
     * 上级科目
     */
    @TableField(value = "parent_id")
    private Integer parentId;

    /**
     * 所在级别
     */
    @TableField(value = "level")
    private Short level;

    /**
     * 是否为系统默认
     */
    @TableField(value = "system_default")
    private Boolean systemDefault;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    /**
     * 科目余额
     */
    @TableField(value = "balance")
    private Double balance;

    /**
     * 单位
     */
    @TableField(value = "unit")
    private String unit;

    /**
     * 辅助核算
     */
    @TableField(value = "auxiliary_accounting")
    private String auxiliaryAccounting;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_TYPE = "type";

    public static final String COL_CODE = "code";

    public static final String COL_NAME = "name";

    public static final String COL_MNEMONIC_CODE = "mnemonic_code";

    public static final String COL_BALANCE_DIRECTION = "balance_direction";

    public static final String COL_STATUS = "status";

    public static final String COL_PARENT_ID = "parent_id";

    public static final String COL_LEVEL = "level";

    public static final String COL_SYSTEM_DEFAULT = "system_default";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_BALANCE = "balance";

    public static final String COL_UNIT = "unit";

    public static final String COL_AUXILIARY_ACCOUNTING = "auxiliary_accounting";
}