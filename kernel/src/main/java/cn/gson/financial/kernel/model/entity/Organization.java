package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

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
@TableName(value = "fxy_financial_organization")
public class Organization implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 公司类型 总公司0 门店1  部门2  初始化账套默认创建账套相同名称总公司
     */
    @TableField(value = "type")
    private Integer type;

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
     * 联系人
     */
    @TableField(value = "linkman")
    private String linkman;

    /**
     * 联系电话
     */
    @TableField(value = "telephone")
    private String telephone;

    /**
     * 状态
     */
    @TableField(value = "status")
    private Boolean status;

    /**
     * 上级
     */
    @TableField(value = "parent_id")
    private Integer parentId;


    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    /**
     * 启用日期
     */
    @TableField(value = "enable_date")
    private Date enableDate;

    /**
     * 当前记账年月
     */
    @TableField(value = "current_account_date")
    private Date currentAccountDate;

    /**
     * 创建人
     */
    @TableField(value = "creator_id")
    private Integer creatorId;

    /**
     * 资产
     */
    @TableField(value = "debt_template_id")
    private Integer debtTemplateId;

    /**
     * 现金
     */
    @TableField(value = "cash_template_id")
    private Integer cashTemplateId;

    /**
     * 利润
     */
    @TableField(value = "profit_template_id")
    private Integer profitTemplateId;

    /**
     * 进销存门店ID
     */
    @TableField(value = "entity_id")
    private Integer entityId;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_TYPE = "type";

    public static final String COL_CODE = "code";

    public static final String COL_NAME = "name";

    public static final String COL_LINKMAN = "linkman";

    public static final String COL_TELEPHONE = "telephone";

    public static final String COL_STATUS = "status";

    public static final String COL_PARENT_ID = "parent_id";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_ENABLE_DATE = "enable_date";

    public static final String COL_CURRENT_ACCOUNT_DATE = "current_account_date";

    public static final String COL_CREATOR_ID = "creator_id";

    public static final String COL_PROFIT_TEMPLATE_ID = "profit_template_id";

    public static final String COL_CASH_TEMPLATE_ID = "cash_template_id";

    public static final String COL_DEBT_TEMPLATE_ID = "debt_template_id";

}