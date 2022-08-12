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
@TableName(value = "fxy_financial_voucher_details_auxiliary")
public class VoucherDetailsAuxiliary implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 凭证明细 Id
     */
    @TableField(value = "voucher_details_id")
    private Integer voucherDetailsId;

    /**
     * 辅助类型 id
     */
    @TableField(value = "accounting_category_id")
    private Integer accountingCategoryId;

    /**
     * 辅助项值 Id
     */
    @TableField(value = "accounting_category_details_id")
    private Integer accountingCategoryDetailsId;

    @TableField(exist = false)
    private AccountingCategoryDetails accountingCategoryDetails;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_VOUCHER_DETAILS_ID = "voucher_details_id";

    public static final String COL_ACCOUNTING_CATEGORY_ID = "accounting_category_id";

    public static final String COL_ACCOUNTING_CATEGORY_DETAILS_ID = "accounting_category_details_id";
}