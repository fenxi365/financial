package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.ReportTemplate;
import cn.gson.financial.kernel.model.vo.ReportDataVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.service</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface ReportTemplateService extends IService<ReportTemplate> {


    int batchInsert(List<ReportTemplate> list);

    Map<Integer, ReportDataVo> view(Integer accountSetsId, Long id, Date accountDate);
}
