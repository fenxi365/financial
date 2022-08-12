package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.UserAccountSets;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.vo.UserVo;
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
        uasQw.eq(UserAccountSets::getUserId, this.currentUser.get().getId());
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
            entity.setCreatorId(this.currentUser.get().getId());
            service.init(entity);

            if (this.accountSetsId.get() == null) {
                //更新 Session 中的用户信息
                UserVo userVo = new UserVo();
                userVo.setId(this.currentUser.get().getId());
                userVo.setAccountSetsId(entity.getId());
                this.userService.updateById(userVo);
                userVo = this.userService.getUserVo(this.currentUser.get().getId());
                session.get().set("user", userVo);
            }

            return JsonResult.successful(entity);
        } catch (Exception e) {
            log.error("账套创建失败！", e);
            return JsonResult.failure("账套创建失败!");
        }
    }

    @Override
    public JsonResult update(@RequestBody AccountSets entity) {
        QueryWrapper qw = Wrappers.query();
        qw.eq("id", entity.getId());
        service.update(entity, qw);
        return JsonResult.successful();
    }


    @GetMapping("addUser")
    public JsonResult addUser(String mobile, String role) {
        this.service.addUser(this.accountSetsId.get(), mobile, role);
        return JsonResult.successful();
    }

    @GetMapping("updateUserRole")
    public JsonResult updateUserRole(Integer id, String role) {
        this.service.updateUserRole(this.accountSetsId.get(), id, role);
        return JsonResult.successful();
    }

    @GetMapping("addNewUser")
    public JsonResult addNewUser(String mobile, String role, String code) {
        String scode = (String) session.get().get(mobile);
        if (scode == null || !scode.equals(code)) {
            return JsonResult.failure("验证码错误!");
        }
        session.get().delete(mobile);
        this.service.addNewUser(this.accountSetsId.get(), mobile, role);
        return JsonResult.successful();
    }

    @GetMapping("removeUser/{uid}")
    public JsonResult removeUser(@PathVariable Integer uid) {
        this.service.removeUser(this.accountSetsId.get(), uid);
        return JsonResult.successful();
    }

    @PostMapping("identification")
    public JsonResult identification(@RequestParam String code) {
        if (code.equals(this.session.get().get(this.currentUser.get().getMobile()))) {
            this.session.get().set(this.currentUser.get().getMobile() + "_checked", true);
            this.session.get().delete(this.currentUser.get().getMobile());
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
            this.service.updateEncode(this.accountSetsId.get(), encoding, newEncoding);
            session.get().set("user", this.userService.getUserVo(this.currentUser.get().getId()));
        }
        return JsonResult.successful();
    }

    @PostMapping("handOver")
    public JsonResult handOver(@RequestParam String code, @RequestParam String mobile) {
        if (this.session.get().get(this.currentUser.get().getMobile() + "_checked") == null) {
            return JsonResult.failure("亲，移交用户信息未确认！");
        }

        if (code.equals(this.session.get().get(mobile))) {
            this.service.handOver(this.accountSetsId.get(), this.currentUser.get().getId(), mobile);
            this.session.get().delete(mobile);
            //更新 Session 中的用户信息
            session.get().set("user", this.userService.getUserVo(this.currentUser.get().getId()));
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
        if (!smsCode.equals(this.session.get().get(this.currentUser.get().getMobile()))) {
            return JsonResult.failure("验证码错误！");
        }
        session.get().delete(this.currentUser.get().getMobile());
        JsonResult rs = super.delete(id);
        if (rs.isSuccess()) {
            //更新 Session 中的用户信息
            session.get().set("user", this.userService.getUserVo(this.currentUser.get().getId()));
        }
        return rs;
    }
}
