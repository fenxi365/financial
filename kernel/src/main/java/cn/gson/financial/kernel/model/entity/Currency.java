package cn.gson.financial.kernel.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

@Data
@TableName(value = "fxy_financial_currency")
public class Currency implements Serializable {
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
     * 汇率
     */
    @TableField(value = "exchange_rate")
    private Double exchangeRate;

    /**
     * 是否本位币
     */
    @TableField(value = "local_currency")
    private Boolean localCurrency;

    /**
     * 所属账套
     */
    @TableField(value = "account_sets_id")
    private Integer accountSetsId;

    private static final long serialVersionUID = 1L;

    public static final String COL_CODE = "code";

    public static final String COL_NAME = "name";

    public static final String COL_EXCHANGE_RATE = "exchange_rate";

    public static final String COL_LOCAL_CURRENCY = "local_currency";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";
}