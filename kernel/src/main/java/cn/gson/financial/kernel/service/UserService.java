package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.User;
import cn.gson.financial.kernel.model.vo.UserVo;
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
public interface UserService extends IService<User> {


    int batchInsert(List<User> list);

    UserVo login(String mobile, String password);

    UserVo getUserVo(Integer userId);

    List<UserVo> listByAccountSetId(Integer accountSetsId);


    void updateUserAccountSetsOrgId(Integer accountSetsId, Integer userId, Integer orgId);

}


