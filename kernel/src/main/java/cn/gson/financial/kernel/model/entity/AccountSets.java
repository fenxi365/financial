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
 * <li>Creation    : 2019年10月16日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_account_sets")
public class AccountSets implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 单位名称
     */
    @TableField(value = "company_name")
    private String companyName;

    /**
     * 账套启用年月
     */
    @TableField(value = "enable_date")
    private Date enableDate;

    /**
     * 统一社会信用代码
     */
    @TableField(value = "credit_code")
    private String creditCode;

    /**
     * 0.企业会计准则、1.企业会计准则、2.民间非营利组织会计制度
     */
    @TableField(value = "accounting_standards")
    private Short accountingStandards;

    /**
     * 单位所在地
     */
    @TableField(value = "address")
    private String address;

    /**
     * 是否启用出纳模块
     */
    @TableField(value = "cashier_module")
    private Byte cashierModule;

    /**
     * 行业
     */
    @TableField(value = "industry")
    private Short industry;

    /**
     * 是否启用固定资产模块
     */
    @TableField(value = "fixed_asset_module")
    private Byte fixedAssetModule;

    /**
     * 增值税种类
     * 0.小规模纳税人、1.一般纳税人
     */
    @TableField(value = "vat_type")
    private Short vatType;

    /**
     * 凭证是否需要审核
     */
    @TableField(value = "voucher_reviewed")
    private Byte voucherReviewed;

    @TableField(value = "create_date")
    private Date createDate;

    /**
     * 创建人
     */
    @TableField(value = "creator_id")
    private Integer creatorId;

    /**
     * 当前记账年月
     */
    @TableField(value = "current_account_date")
    private Date currentAccountDate;

    /**
     * 科目编码方式
     */
    @TableField(value = "encoding")
    private String encoding;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_COMPANY_NAME = "company_name";

    public static final String COL_ENABLE_DATE = "enable_date";

    public static final String COL_CREDIT_CODE = "credit_code";

    public static final String COL_ACCOUNTING_STANDARDS = "accounting_standards";

    public static final String COL_ADDRESS = "address";

    public static final String COL_CASHIER_MODULE = "cashier_module";

    public static final String COL_INDUSTRY = "industry";

    public static final String COL_FIXED_ASSET_MODULE = "fixed_asset_module";

    public static final String COL_VAT_TYPE = "vat_type";

    public static final String COL_VOUCHER_REVIEWED = "voucher_reviewed";

    public static final String COL_CREATE_DATE = "create_date";

    public static final String COL_CREATOR_ID = "creator_id";

    public static final String COL_CURRENT_ACCOUNT_DATE = "current_account_date";

    public static final String COL_ENCODING = "encoding";
}