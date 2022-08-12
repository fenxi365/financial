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
 * <li>Creation    : 2019年08月29日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@TableName(value = "fxy_financial_user")
public class User implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 电话
     */
    @TableField(value = "mobile")
    private String mobile;

    /**
     * 密码
     */
    @TableField(value = "password")
    private String password;

    /**
     * 微信 unionId
     */
    @TableField(value = "union_id")
    private String unionId;

    /**
     * 微信 openId
     */
    @TableField(value = "open_id")
    private String openId;

    /**
     * 昵称
     */
    @TableField(value = "nickname")
    private String nickname;

    /**
     * 头像
     */
    @TableField(value = "avatar_url")
    private String avatarUrl;

    /**
     * 真实姓名
     */
    @TableField(value = "real_name")
    private String realName;

    @TableField(value = "account_sets_id", updateStrategy = FieldStrategy.IGNORED)
    private Integer accountSetsId;

    @TableField(value = "create_date")
    private Date createDate;

    /**
     * 默认密码
     */
    @TableField(value = "init_password")
    private String initPassword;

    /**
     * 邮箱
     */
    @TableField(value = "email")
    private String email;

    private static final long serialVersionUID = 1L;

    public static final String COL_ID = "id";

    public static final String COL_MOBILE = "mobile";

    public static final String COL_PASSWORD = "password";

    public static final String COL_UNION_ID = "union_id";

    public static final String COL_OPEN_ID = "open_id";

    public static final String COL_NICKNAME = "nickname";

    public static final String COL_AVATAR_URL = "avatar_url";

    public static final String COL_REAL_NAME = "real_name";

    public static final String COL_ACCOUNT_SETS_ID = "account_sets_id";

    public static final String COL_CREATE_DATE = "create_date";

    public static final String COL_INIT_PASSWORD = "init_password";

    public static final String COL_EMAIL = "email";
}