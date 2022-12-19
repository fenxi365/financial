package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.UserAccountSets;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.service.AccountSetsService;
import cn.gson.financial.kernel.service.UserAccountSetsService;
import cn.gson.financial.kernel.service.UserService;
import cn.gson.financial.kernel.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
@RequestMapping("/account-sets")
@AllArgsConstructor
@Slf4j
public class AccountSetsController extends BaseCrudController<AccountSetsService, AccountSets> {

    private UserAccountSetsService userAccountSetsService;

    private VoucherService voucherService;

    private UserService userService;

    @Override
    public JsonResult list(Map<String, String> params) {
        // 1.从中间表查出当前用户的所有账套
        LambdaQueryWrapper<UserAccountSets> uasQw = Wrappers.lambdaQuery();
        uasQw.eq(UserAccountSets::getUserId, this.currentUser.getId());
        List<UserAccountSets> list = userAccountSetsService.list(uasQw);

        if (list.size() > 0) {
            // 2.获取账套信息
            QueryWrapper<AccountSets> asQw = Wrappers.query();
            IntStream intStream = list.stream().mapToInt(UserAccountSets::getAccountSetsId);
            asQw.in("id", intStream.boxed().collect(Collectors.toList()));
            asQw.allEq(params);
            this.getPageList(params, userAccountSetsService);

            return JsonResult.successful(this.service.list(asQw));
        }
        return JsonResult.successful();
    }

    @Override
    public JsonResult save(@RequestBody AccountSets entity) {
        try {
            entity.setCurrentAccountDate(entity.getEnableDate());
            entity.setCreatorId(this.currentUser.getId());
            service.save(entity);

            //更新 Session 中的用户信息
            session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));

            return JsonResult.successful(entity);
        } catch (Exception e) {
            log.error("账套创建失败！", e);
            return JsonResult.failure("账套创建失败!");
        }
    }

    @Override
    public JsonResult update(@RequestBody AccountSets entity) {
        JsonResult result = super.update(entity);
        if (result.isSuccess() && entity.getId().equals(this.accountSetsId)) {
            //更新 Session 中的用户信息
            session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));
        }
        return result;
    }


    @GetMapping("addUser")
    public JsonResult addUser(String mobile, String role) {
        this.service.addUser(this.accountSetsId, mobile, role);
        return JsonResult.successful();
    }

    @GetMapping("updateUserRole")
    public JsonResult updateUserRole(Integer id, String role) {
        this.service.updateUserRole(this.accountSetsId, id, role);
        return JsonResult.successful();
    }

    @GetMapping("addNewUser")
    public JsonResult addNewUser(String mobile, String role, String code, HttpSession session) {
        String scode = (String) session.getAttribute(mobile);
        if (scode == null || !scode.equals(code)) {
            return JsonResult.failure("验证码错误!");
        }
        session.removeAttribute(mobile);
        this.service.addNewUser(this.accountSetsId, mobile, role);
        return JsonResult.successful();
    }

    @GetMapping("removeUser/{uid}")
    public JsonResult removeUser(@PathVariable Integer uid) {
        this.service.removeUser(this.accountSetsId, uid);
        return JsonResult.successful();
    }

    @PostMapping("identification")
    public JsonResult identification(@RequestParam String code) {
        if (code.equals(this.session.getAttribute(this.currentUser.getMobile()))) {
            this.session.setAttribute(this.currentUser.getMobile() + "_checked", true);
            this.session.removeAttribute(this.currentUser.getMobile());
            return JsonResult.successful();
        }
        return JsonResult.failure("验证码校验失败！");
    }

    /**
     * 更新科目编码设置
     *
     * @param encoding
     * @param newEncoding
     * @return
     */
    @PostMapping("updateEncode")
    public JsonResult updateEncode(@RequestParam String encoding, @RequestParam String newEncoding) {
        if (!encoding.equals(newEncoding)) {
            this.service.updateEncode(this.accountSetsId, encoding, newEncoding);
            session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));
        }
        return JsonResult.successful();
    }

    @PostMapping("handOver")
    public JsonResult handOver(@RequestParam String code, @RequestParam String mobile) {
        if (this.session.getAttribute(this.currentUser.getMobile() + "_checked") == null) {
            return JsonResult.failure("亲，移交用户信息未确认！");
        }

        if (code.equals(this.session.getAttribute(mobile))) {
            this.service.handOver(this.accountSetsId, this.currentUser.getId(), mobile);
            this.session.removeAttribute(mobile);
            //更新 Session 中的用户信息
            session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));
            return JsonResult.successful();
        }

        return JsonResult.failure("验证码校验失败！");
    }

    /**
     * 检查账套是否已有凭证
     *
     * @param asid 账套 ID
     * @return
     */
    @GetMapping("checkUse")
    public JsonResult checkUse(@RequestParam Integer asid) {
        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getAccountSetsId, asid);
        return JsonResult.successful(this.voucherService.count(qw) > 0);
    }

    /**
     * 屏蔽默认的删除操作
     *
     * @param id
     * @return
     */
    @Override
    public JsonResult delete(Long id) {
        return JsonResult.failure();
    }

    /**
     * 带验证码删除
     *
     * @param id
     * @param smsCode
     * @return
     */
    @DeleteMapping("/{id:\\d+}/{smsCode}")
    public JsonResult delete(@PathVariable Long id, @PathVariable String smsCode) {
        if (!smsCode.equals(this.session.getAttribute(this.currentUser.getMobile()))) {
            return JsonResult.failure("验证码错误！");
        }
        session.removeAttribute(this.currentUser.getMobile());
        JsonResult rs = super.delete(id);
        if (rs.isSuccess()) {
            //更新 Session 中的用户信息
            session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));
        }
        return rs;
    }
}
