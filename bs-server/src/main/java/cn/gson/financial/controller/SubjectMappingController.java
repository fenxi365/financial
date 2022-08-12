package cn.gson.financial.controller;

import cn.gson.financial.base.BaseController;
import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.entity.SubjectMateriel;
import cn.gson.financial.kernel.model.entity.SubjectSupplier;
import cn.gson.financial.kernel.service.SubjectMaterielService;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.SubjectSupplierService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/17 10:11</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@RestController
@RequestMapping("/subject/mapping")
public class SubjectMappingController extends BaseController {

    @Autowired
    private SubjectSupplierService subjectSupplierService;

    @Autowired
    private SubjectMaterielService subjectMaterielService;

    @GetMapping("materiel")
    public JsonResult materielSubject() {
       return  JsonResult.successful(subjectMaterielService.materielSubject(this.accountSetsId.get()));
    }

    @GetMapping("supplier")
    public JsonResult supplierSubject() {
        return  JsonResult.successful(subjectSupplierService.supplierSubject(this.accountSetsId.get()));
    }
    @PostMapping("materiel")
    public JsonResult materielSave(@RequestBody List<SubjectMateriel> entity) {
        try {
            subjectMaterielService.saveAll(entity,this.accountSetsId.get());
            return JsonResult.successful();
        } catch (Exception e) {
            log.error("创建失败！", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    @PostMapping("supplier")
    public JsonResult supplierSave(@RequestBody List<SubjectSupplier> entity) {
        try {
            subjectSupplierService.saveAll(entity,this.accountSetsId.get());
            return JsonResult.successful();
        } catch (Exception e) {
            log.error("创建失败！", e);
            return JsonResult.failure(e.getMessage());
        }
    }
}
