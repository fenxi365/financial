package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.ReportTemplate;
import cn.gson.financial.kernel.service.ReportTemplateService;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

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
@RequestMapping("/report/template")
public class ReportTemplateController extends BaseCrudController<ReportTemplateService, ReportTemplate> {

    @GetMapping("view/{id:\\d+}")
    public JsonResult view(@PathVariable Long id, @RequestParam Date accountDate) {
        return JsonResult.successful(service.view(this.accountSetsId, id, accountDate));
    }
}
