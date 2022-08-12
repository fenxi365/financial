package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.SubjectMateriel;
import cn.gson.financial.kernel.model.entity.SubjectSupplier;
import cn.gson.financial.kernel.model.vo.SubjectMaterielVo;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/17 9:39</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface SubjectMaterielService {

    void saveAll(List<SubjectMateriel> entity, Integer accountSetsId);

    List<SubjectMaterielVo> materielSubject(Integer accountSetsId);

}
