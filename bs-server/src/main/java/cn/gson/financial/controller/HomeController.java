package cn.gson.financial.controller;

import cn.gson.financial.base.BaseController;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月10日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/home")
public class HomeController extends BaseController {

    @Autowired
    private VoucherService voucherService;

    @GetMapping("/voucher/count")
    public JsonResult info() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.currentUser.getAccountSets().getCurrentAccountDate());
        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getAccountSetsId, this.accountSetsId);
        qw.eq(Voucher::getVoucherYear, cal.get(Calendar.YEAR));
        qw.eq(Voucher::getVoucherMonth, cal.get(Calendar.MONTH) + 1);
        return JsonResult.successful(voucherService.count(qw));
    }

    /**
     * 收入和利润图表数据
     *
     * @return
     */
    @GetMapping("/chart/revenueProfit")
    public JsonResult revenueProfitChart() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.currentUser.getAccountSets().getCurrentAccountDate());
        List<Map<String, Object>> homeReport = voucherService.getHomeReport(accountSetsId, cal.get(Calendar.YEAR));
        //根据类型和年进行分组
        Map<String, Map<Object, Double>> collect = homeReport.stream().collect(
                Collectors.groupingBy(
                        som -> som.get("type").toString(),
                        Collectors.toMap(
                                o -> o.get("voucher_month"),
                                o -> DoubleValueUtil.getNotNullVal((Double) o.get("credit_amount"))
                        )
                )
        );
        return JsonResult.successful(collect);
    }

    /**
     * 收入和利润图表数据
     *
     * @return
     */
    @GetMapping("/chart/cost")
    public JsonResult costReport() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.currentUser.getAccountSets().getCurrentAccountDate());
        List<Map<String, Object>> homeReport = voucherService.getCostReport(accountSetsId, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1);
        return JsonResult.successful(getStringListMap(homeReport));
    }


    /**
     * 收入和利润图表数据
     *
     * @return
     */
    @GetMapping("/chart/cash")
    public JsonResult cashReport() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.currentUser.getAccountSets().getCurrentAccountDate());
        List<Map<String, Object>> homeReport = voucherService.getCashReport(accountSetsId, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1);
        //根据类型和年进行分组
        return JsonResult.successful(getStringListMap(homeReport));
    }


    private List<Map<String, Object>> getStringListMap(List<Map<String, Object>> homeReport) {
        Map<String, List<Double>> collect = homeReport.stream().collect(
                Collectors.groupingBy(
                        som -> som.get("type").toString(),
                        Collectors.mapping(
                                o -> DoubleValueUtil.getNotNullVal((Double) o.get("debit_amount")) - DoubleValueUtil.getNotNullVal((Double) o.get("credit_amount")),
                                Collectors.toList()
                        )
                )
        );

        List<Map<String, Object>> data = new ArrayList<>(collect.size());
        collect.forEach((key, value) -> {
            Map<String, Object> item = new HashMap<>(2);
            item.put("name", key);
            item.put("value", value.stream().mapToDouble(Double::doubleValue).sum());
            data.add(item);
        });
        return data;
    }
}
