package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.Organization;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.vo.BalanceVo;
import cn.gson.financial.kernel.model.vo.OrganizationVo;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Date;
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
public interface OrganizationService extends IService<Organization> {

    /**
     * vo
     *
     * @param queryWrapper
     * @return
     */
     List<OrganizationVo> listVo(Wrapper<Organization> queryWrapper);

     boolean remove(Wrapper<Organization> wrapper);

     void updateEntityId(List<Organization> entity);
}





