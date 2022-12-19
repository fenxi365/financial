package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.ReportTemplateItems;
import cn.gson.financial.kernel.model.entity.ReportTemplateItemsFormula;
import cn.gson.financial.kernel.service.ReportTemplateItemsService;
import lombok.Data;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/report/template/items")
public class ReportTemplateItemsController extends BaseCrudController<ReportTemplateItemsService, ReportTemplateItems> {


    @PostMapping("formula")
    public JsonResult saveFormula(@RequestBody FormulaForm formulaForm) {
        service.saveFormula(formulaForm.getTemplateItemsId(), formulaForm.getFormulas(), this.accountSetsId);
        return JsonResult.successful();
    }

    @Data
    static class FormulaForm {
        List<ReportTemplateItemsFormula> formulas;
        Integer templateItemsId;
    }
}
