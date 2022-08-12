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
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_report_template_items_formula")
public class ReportTemplateItemsFormula implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 模板 id
     */
    @TableField(value = "template_id")
    private Integer templateId;

    @TableField(value = "template_items_id")
    private Integer templateItemsId;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    /**
     * 计算方式
     */
    @TableField(value = "calculation")
    private Object calculation;

    /**
     * 取数规则：0,净发生额度 1,借方发生额 2,贷方发生额
     */
    @TableField(value = "access_rules")
    private Integer accessRules;

    /**
     * 数据来源标识
     */
    @TableField(value = "from_tag")
    private String fromTag;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_TEMPLATE_ID = "template_id";

    public static final String COL_TEMPLATE_ITEMS_ID = "template_items_id";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_CALCULATION = "calculation";

    public static final String COL_ACCESS_RULES = "access_rules";

    public static final String COL_FROM_TAG = "from_tag";
}