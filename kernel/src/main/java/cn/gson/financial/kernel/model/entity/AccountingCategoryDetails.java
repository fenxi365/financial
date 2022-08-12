package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName(value = "fxy_financial_accounting_category_details")
public class AccountingCategoryDetails implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 编码
     */
    @TableField(value = "code")
    private String code;

    /**
     * 名称
     */
    @TableField(value = "name")
    private String name;

    /**
     * 备注
     */
    @TableField(value = "remark")
    private String remark;

    /**
     * 是否启用
     */
    @TableField(value = "enable")
    private Boolean enable;

    @TableField(value = "accounting_category_id")
    private Integer accountingCategoryId;

    @TableField(value = "cus_column_0")
    private String cusColumn0;

    @TableField(value = "cus_column_1")
    private String cusColumn1;

    @TableField(value = "cus_column_2")
    private String cusColumn2;

    @TableField(value = "cus_column_3")
    private String cusColumn3;

    @TableField(value = "cus_column_4")
    private String cusColumn4;

    @TableField(value = "cus_column_5")
    private String cusColumn5;

    @TableField(value = "cus_column_6")
    private String cusColumn6;

    @TableField(value = "cus_column_7")
    private String cusColumn7;

    @TableField(value = "cus_column_8")
    private String cusColumn8;

    @TableField(value = "cus_column_9")
    private String cusColumn9;

    @TableField(value = "cus_column_10")
    private String cusColumn10;

    @TableField(value = "cus_column_11")
    private String cusColumn11;

    @TableField(value = "cus_column_12")
    private String cusColumn12;

    @TableField(value = "cus_column_13")
    private String cusColumn13;

    @TableField(value = "cus_column_14")
    private String cusColumn14;

    @TableField(value = "cus_column_15")
    private String cusColumn15;

    private static final long serialVersionUID = 1L;

    public static final String COL_CODE = "code";

    public static final String COL_NAME = "name";

    public static final String COL_REMARK = "remark";

    public static final String COL_ENABLE = "enable";

    public static final String COL_ACCOUNTING_CATEGORY_ID = "accounting_category_id";

    public static final String COL_CUS_COLUMN_0 = "cus_column_0";

    public static final String COL_CUS_COLUMN_1 = "cus_column_1";

    public static final String COL_CUS_COLUMN_2 = "cus_column_2";

    public static final String COL_CUS_COLUMN_3 = "cus_column_3";

    public static final String COL_CUS_COLUMN_4 = "cus_column_4";

    public static final String COL_CUS_COLUMN_5 = "cus_column_5";

    public static final String COL_CUS_COLUMN_6 = "cus_column_6";

    public static final String COL_CUS_COLUMN_7 = "cus_column_7";

    public static final String COL_CUS_COLUMN_8 = "cus_column_8";

    public static final String COL_CUS_COLUMN_9 = "cus_column_9";

    public static final String COL_CUS_COLUMN_10 = "cus_column_10";

    public static final String COL_CUS_COLUMN_11 = "cus_column_11";

    public static final String COL_CUS_COLUMN_12 = "cus_column_12";

    public static final String COL_CUS_COLUMN_13 = "cus_column_13";

    public static final String COL_CUS_COLUMN_14 = "cus_column_14";

    public static final String COL_CUS_COLUMN_15 = "cus_column_15";
}