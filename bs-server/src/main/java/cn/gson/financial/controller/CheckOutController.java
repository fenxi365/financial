package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Checkout;
import cn.gson.financial.kernel.service.CheckoutService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月03日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/checkout")
public class CheckOutController extends BaseCrudController<CheckoutService, Checkout> {
    DateFormat df = new SimpleDateFormat("yyyyMM");

    /**
     * 期初检查
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("initialCheck")
    public JsonResult initialCheck(@RequestParam Integer year, @RequestParam Integer month) {
        //判断是否是结转第一期，如果是第一期，则需要检查期初平衡
        if (!df.format(this.currentUser.getAccountSets().getEnableDate()).equals(year + "" + month)) {
            return JsonResult.instance(this.service.initialCheck(this.accountSetsId));
        }
        return JsonResult.successful();
    }

    /**
     * 期末检查
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("finalCheck")
    public JsonResult finalCheck(@RequestParam Integer year, @RequestParam Integer month) {
        return JsonResult.instance(this.service.finalCheck(this.accountSetsId, year, month));
    }

    /**
     * 报表检查
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("reportCheck")
    public JsonResult reportCheck(@RequestParam Integer year, @RequestParam Integer month) {
        return JsonResult.successful(this.service.reportCheck(this.accountSetsId, year, month));
    }

    /**
     * 断号检查
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("brokenCheck")
    public JsonResult brokenCheck(@RequestParam Integer year, @RequestParam Integer month) {
        return JsonResult.instance(this.service.brokenCheck(this.accountSetsId, year, month));
    }

    /**
     * 结账
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("invoicing")
    public JsonResult invoicing(@RequestParam Integer year, @RequestParam Integer month) {
        if (!this.service.invoicing(this.currentUser, year, month)) {
            return JsonResult.failure();
        }
        return JsonResult.successful();
    }

    /**
     * 反结账
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("unCheck")
    public JsonResult unCheck(@RequestParam Integer year, @RequestParam Integer month) {
        if (!this.service.unCheck(this.currentUser, year, month)) {
            return JsonResult.failure();
        }
        return JsonResult.successful();
    }
}
