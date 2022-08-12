package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.entity</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月18日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_report_template_items")
public class ReportTemplateItems implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "template_id")
    private Integer templateId;

    /**
     * 标题
     */
    @TableField(value = "title")
    private String title;

    @TableField(value = "parent_id")
    private Integer parentId;

    /**
     * 行次
     */
    @TableField(value = "line_num")
    private Integer lineNum;

    /**
     * 资产负载类型时需要设置
     * 0,资产 1,负债 2，所有者权益
     */
    @TableField(value = "type")
    private Integer type;

    /**
     * 取数来原:0,表外公式,1,表内公式
     */
    @TableField(value = "sources")
    private Integer sources;

    /**
     * 层级
     */
    @TableField(value = "level")
    private Integer level;

    /**
     * 是否加粗标题
     */
    @TableField(value = "is_bolder")
    private Boolean isBolder;

    /**
     * 是否可以折叠
     */
    @TableField(value = "is_folding")
    private Boolean isFolding;

    /**
     * 是否是归类项，归类项没有行号
     */
    @TableField(value = "is_classified")
    private Boolean isClassified;

    /**
     * 显示位置
     */
    @TableField(value = "pos")
    private Integer pos;

    @TableField(exist = false)
    private List<ReportTemplateItemsFormula> formulas;

    @TableField(exist = false)
    private List<ReportTemplateItems> children;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_TEMPLATE_ID = "template_id";

    public static final String COL_TITLE = "title";

    public static final String COL_PARENT_ID = "parent_id";

    public static final String COL_LINE_NUM = "line_num";

    public static final String COL_TYPE = "type";

    public static final String COL_SOURCES = "sources";

    public static final String COL_LEVEL = "level";

    public static final String COL_IS_BOLDER = "is_bolder";

    public static final String COL_IS_FOLDING = "is_folding";

    public static final String COL_IS_CLASSIFIED = "is_classified";

    public static final String COL_POS = "pos";
}