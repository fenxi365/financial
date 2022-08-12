package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.ReportTemplateItems;
import cn.gson.financial.kernel.model.entity.ReportTemplateItemsFormula;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

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
public interface ReportTemplateItemsService extends IService<ReportTemplateItems> {


    int batchInsert(List<ReportTemplateItems> list);

    /**
     * 保存公式信息
     *
     * @param formulas
     * @param accountSetsId
     * @param templateItemsId
     */
    void saveFormula(Integer templateItemsId, List<ReportTemplateItemsFormula> formulas, Integer accountSetsId);

    void resetLine(Integer templateId);
}




