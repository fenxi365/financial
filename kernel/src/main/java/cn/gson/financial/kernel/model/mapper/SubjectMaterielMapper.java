package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.SubjectMateriel;
import cn.gson.financial.kernel.model.vo.SubjectMaterielVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/17 9:38</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Mapper
public interface SubjectMaterielMapper extends BaseMapper<SubjectMateriel> {

    List<SubjectMaterielVo> selectSubjectMaterielVo(@Param("accountSetsId") Integer accountSetsId);
}
