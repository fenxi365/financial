package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.Organization;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.vo.OrganizationVo;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 组织机构</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022年02月13日</li>
 * <li>@author     : 李泽龙</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Mapper
public interface OrganizationMapper extends BaseMapper<Organization> {

    List<OrganizationVo> selectOrganizationVo(@Param(Constants.WRAPPER) Wrapper queryWrapper);
}