package cn.gson.financial.controller;

import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.StpUtil;
import cn.gson.financial.api.Inventory;
import cn.gson.financial.base.BaseController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.AccountSetsService;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 进销存</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/13 16:30</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@RestController
@RequestMapping("/inventory")
public class InventoryController extends BaseController {

    @Autowired
    private AccountSetsService accountSetsService;

    @PostMapping("login")
    public JsonResult login(String username, String password) {
        try {
            JsonResult result = Inventory.login(username, password);

            SaSession session = StpUtil.getTokenSession();
            UserVo userVo = session.getModel("user", UserVo.class);
            userVo.getAccountSets().setToken(result.getMsg());
            AccountSets accountSets = new AccountSets();
            accountSets.setToken(result.getMsg());
            LambdaUpdateWrapper<AccountSets> update = Wrappers.lambdaUpdate();
            update.eq(AccountSets::getId, userVo.getAccountSets().getId());
            accountSetsService.getBaseMapper().update(accountSets, update);
            session.set("user", userVo);
            return result;
        } catch (Exception e) {
            log.error("进销存登录错误~", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    @GetMapping("supplier")
    public JsonResult supplierList() {
        try {
            SaSession session = StpUtil.getTokenSession();
            UserVo userVo = session.getModel("user", UserVo.class);
            return Inventory.supplierList(userVo.getAccountSets().getToken());
        } catch (Exception e) {
            log.error("进销存供应商获取错误~", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    @GetMapping("material")
    public JsonResult materialList() {
        try {
            SaSession session = StpUtil.getTokenSession();
            UserVo userVo = session.getModel("user", UserVo.class);
            return Inventory.materialList(userVo.getAccountSets().getToken());
        } catch (Exception e) {
            log.error("进销存物料获取错误~", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    @GetMapping("org")
    public JsonResult orgList() {
        try {
            SaSession session = StpUtil.getTokenSession();
            UserVo userVo = session.getModel("user", UserVo.class);
            return Inventory.orgList(userVo.getAccountSets().getToken());
        } catch (Exception e) {
            log.error("进销存门店获取错误~", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    @GetMapping("order")
    public JsonResult orderList(@RequestParam Map<String, String> params) {
        try {
            SaSession session = StpUtil.getTokenSession();
            UserVo userVo = session.getModel("user", UserVo.class);
            params.put("organizationId", userVo.getOrg().getEntityId() + "");
            return Inventory.orderList(userVo.getAccountSets().getToken(), params);
        } catch (Exception e) {
            log.error("进销存订单获取错误~", e);
            return JsonResult.failure(e.getMessage());
        }
    }
    @GetMapping("order/detail/{id:\\d+}")
    public JsonResult orderDetail(@PathVariable Integer id) {
        try {
            SaSession session = StpUtil.getTokenSession();
            UserVo userVo = session.getModel("user", UserVo.class);
            return Inventory.orderDetail(userVo.getAccountSets().getToken(), id,userVo.getOrg().getEntityId());
        } catch (Exception e) {
            log.error("进销存订单详情获取错误~", e);
            return JsonResult.failure(e.getMessage());
        }
    }
}
