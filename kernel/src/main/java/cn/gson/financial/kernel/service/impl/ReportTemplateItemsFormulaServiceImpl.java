package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.model.entity.ReportTemplateItemsFormula;
import cn.gson.financial.kernel.model.mapper.ReportTemplateItemsFormulaMapper;
import cn.gson.financial.kernel.service.ReportTemplateItemsFormulaService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.service.impl</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
public class ReportTemplateItemsFormulaServiceImpl extends ServiceImpl<ReportTemplateItemsFormulaMapper, ReportTemplateItemsFormula> implements ReportTemplateItemsFormulaService {

    @Override
    public int batchInsert(List<ReportTemplateItemsFormula> list) {
        return baseMapper.batchInsert(list);
    }
}
