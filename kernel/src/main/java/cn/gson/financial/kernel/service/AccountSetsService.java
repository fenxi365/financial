package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface AccountSetsService extends IService<AccountSets> {


    int batchInsert(List<AccountSets> list);

    List<AccountSets> myAccountSets(Integer uid);

    void addUser(Integer accountSetsId, String mobile, String role);

    User addNewUser(Integer accountSetsId, String mobile, String role);

    void removeUser(Integer accountSetsId, Integer uid);

    void updateUserRole(Integer accountSetsId, Integer uid, String role);

    /**
     * 账套移交
     *
     * @param accountSetsId
     * @param currentUserId
     * @param mobile
     */
    void handOver(Integer accountSetsId, Integer currentUserId, String mobile);

    void updateEncode(Integer accountSetsId, String encoding, String newEncoding);


    void init(AccountSets accountSets);

}




