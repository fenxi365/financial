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
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_report_template")
public class ReportTemplate implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "name")
    private String name;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    @TableField(value = "template_key")
    private String templateKey;

    /**
     * 报表类型：0普通报表，1资产报表
     */
    @TableField(value = "type")
    private Integer type;

    @TableField(exist = false)
    private List<ReportTemplateItems> items;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_NAME = "name";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_TEMPLATE_KEY = "template_key";

    public static final String COL_TYPE = "type";
}