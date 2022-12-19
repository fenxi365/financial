package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.AccountingCategory;
import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.service.AccountingCategoryDetailsService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/accounting-category-details")
@Slf4j
public class AccountingCategoryDetailsController extends BaseCrudController<AccountingCategoryDetailsService, AccountingCategoryDetails> {

    @Override
    public JsonResult list(@RequestParam Map<String, String> params) {
        LambdaQueryWrapper<AccountingCategoryDetails> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategoryDetails::getAccountingCategoryId, params.get("accounting_category_id"));
        Page<AccountingCategoryDetails> pageable = new Page<>(Integer.parseInt(params.get("page")), 10);
        String keyword = params.get("keyword");
        if (StringUtils.isNotEmpty(keyword)) {
            qw.and(dqw -> dqw.eq(AccountingCategoryDetails::getCode, keyword).or().eq(AccountingCategoryDetails::getName, keyword));
        }
        qw.orderByAsc(AccountingCategoryDetails::getCode);
        return JsonResult.successful(service.page(pageable, qw));
    }

    /**
     * 清空元素
     *
     * @param id
     * @return
     */
    @DeleteMapping("/clear/{id:\\d+}")
    public JsonResult clear(@PathVariable Integer id) {
        try {
            service.clear(id, this.accountSetsId);
            return JsonResult.successful();
        } catch (Exception e) {
            log.error("清空失败！", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    /**
     * 加载核算项目
     *
     * @param categories
     * @return
     */
    @PostMapping("loadAuxiliaryAccountingData")
    public JsonResult loadAuxiliaryAccountingData(@RequestBody List<AccountingCategory> categories) {
        Map<Integer, List> listMap = new HashMap<>(categories.size());
        categories.stream().forEach(category -> {
            LambdaQueryWrapper<AccountingCategoryDetails> qw = Wrappers.lambdaQuery();
            qw.eq(AccountingCategoryDetails::getAccountingCategoryId, category.getId());
            qw.eq(AccountingCategoryDetails::getEnable, true);
            listMap.put(category.getId(), service.list(qw));
        });

        return JsonResult.successful(listMap);
    }
}
