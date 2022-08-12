package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.Subject;
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
 * <li>Description : cn.gson.financial.kernel.model.mapper</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Mapper
public interface SubjectMapper extends BaseMapper<Subject> {
    int batchInsert(@Param("list") List<Subject> list);

    List<Subject> selectNoChildrenSubject(@Param(Constants.WRAPPER) Wrapper wrapper);

    List<Subject> selectAccountBookList(@Param("accountDate") Date accountDate, @Param("accountSetsId") Integer accountSetsId, @Param("showNumPrice") boolean showNumPrice,@Param("orgId") Integer orgId);

    List<SubjectVo> selectSubjectVo(@Param(Constants.WRAPPER) Wrapper queryWrapper);

    List<Integer> selectLeaf(@Param("accountSetsId") Integer accountSetsId);

    List<Subject> selectBalanceSubjectList(@Param("accountDate") Date accountDate, @Param("accountSetsId") Integer accountSetsId, @Param("showNumPrice") boolean showNumPrice);
}