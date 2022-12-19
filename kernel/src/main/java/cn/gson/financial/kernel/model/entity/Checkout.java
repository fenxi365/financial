package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.entity</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月04日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_checkout")
public class Checkout implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    @TableField(value = "check_year")
    private Integer checkYear;

    @TableField(value = "check_month")
    private Integer checkMonth;

    /**
     * 0,未结转损益、未结账,1,已结转损益、未结账,2,已结转损益、已结账
     */
    @TableField(value = "status")
    private Integer status;

    @TableField(value = "check_date", updateStrategy = FieldStrategy.IGNORED)
    private Date checkDate;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_CHECK_YEAR = "check_year";

    public static final String COL_CHECK_MONTH = "check_month";

    public static final String COL_STATUS = "status";

    public static final String COL_CHECK_DATE = "check_date";
}