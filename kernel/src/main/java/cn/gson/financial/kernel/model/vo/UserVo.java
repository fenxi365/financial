package cn.gson.financial.kernel.model.vo;

import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.Checkout;
import cn.gson.financial.kernel.model.entity.Organization;
import cn.gson.financial.kernel.model.entity.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.vo</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月27日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class UserVo extends User {

    private AccountSets accountSets;

    private String role;

    private List<AccountSets> accountSetsList;

    private List<Checkout> checkoutList;

    //当前账套机构
    private List<Organization> orgList;

    //选择的账套
    private Organization org;

    public Integer getOrgId() {
        return org != null ? org.getId() : null;
    }
}
