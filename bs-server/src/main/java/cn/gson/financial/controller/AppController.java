package cn.gson.financial.controller;

import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.SaLoginModel;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.gson.financial.annotation.IgnoresLogin;
import cn.gson.financial.base.BaseController;
import cn.gson.financial.kernel.aliyuncs.SmsService;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Organization;
import cn.gson.financial.kernel.model.entity.User;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.CheckoutService;
import cn.gson.financial.kernel.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

import static cn.gson.financial.kernel.aliyuncs.SmsService.SmsBody;

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
@Slf4j
@RestController
@RequiredArgsConstructor
public class AppController extends BaseController {


    private final UserService userService;

    private final SmsService smsService;

    private final CheckoutService checkoutService;

    @Value("${aliyun.sms.signature}")
    private String smsSignature;

    @Value("${aliyun.sms.template-code.verification}")
    private String verificationCode;

    @Value("${aliyun.sms.template-code.register}")
    private String registerCode;

    @IgnoresLogin
    @RequestMapping
    public JsonResult index() {
        return JsonResult.successful().setMsg("纷析云财务");
    }

    /**
     * 检查登录状获取态和并返回登录信息
     *
     * @return
     */
    @IgnoresLogin
    @GetMapping("/init")
    public JsonResult init() {
        try {
            SaSession session = StpUtil.getTokenSession();
            UserVo user = session.getModel("user", UserVo.class);
            if (user == null) {
                return JsonResult.failure();
            }
            return JsonResult.successful(user);
        } catch (Exception e) {
            return JsonResult.failure();
        }
    }

    /**
     * 登录
     *
     * @param mobile
     * @param password
     * @param forever  是否是永久登录
     * @return
     */
    @IgnoresLogin
    @PostMapping("/login")
    public JsonResult login(String mobile, String password, @RequestParam(defaultValue = "false") Boolean forever, HttpServletResponse response) {
        UserVo user = userService.login(mobile, password);
        if (forever) {
            StpUtil.login(user.getId(), SaLoginModel.create().setTimeout(-1));
            SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
            response.addHeader(tokenInfo.tokenName, tokenInfo.tokenValue);
        } else {
            StpUtil.login(user.getId());
        }
        SaSession session = StpUtil.getTokenSession();
        if (user.getAccountSetsList().size() <= 0 || user.getAccountSetsList().size() == 1) {
            session.set("user", user);
        }
        return JsonResult.successful(user);
    }

    /**
     * 登出
     *
     * @return
     */
    @GetMapping("/logout")
    public JsonResult logout() {
        StpUtil.logout();
        return JsonResult.successful();
    }

    /**
     * 发送短信验证码
     *
     * @param mobile
     * @return
     */
    @IgnoresLogin
    @GetMapping("/sendMsg/{mobile}")
    public JsonResult sendMsg(@PathVariable String mobile) {
        String numeric = RandomStringUtils.randomNumeric(4);
        log.info("验证码：" + numeric);
        this.sendSmsCode(mobile, numeric);
        this.session.get().set(mobile, numeric);
        return JsonResult.successful();
    }


    /**
     * 注册发送短信验证码
     *
     * @param mobile
     * @return
     */
    @IgnoresLogin
    @GetMapping("/regMsg/{mobile}")
    public JsonResult regMsg(@PathVariable String mobile, HttpSession session) {
        LambdaQueryWrapper<User> qw = Wrappers.lambdaQuery();
        qw.eq(User::getMobile, mobile);
        if (this.userService.count(qw) > 0) {
            return JsonResult.failure("此手机号已被注册，请直接用这个手机号登录或者更换手机号注册！");
        }
        String numeric = RandomStringUtils.randomNumeric(4);
        log.info("验证码：" + numeric);
        this.sendSmsCode(mobile, numeric);
        session.setAttribute(mobile, numeric);
        return JsonResult.successful();
    }

    /**
     * 注册
     *
     * @param mobile
     * @return
     */
    @IgnoresLogin
    @PostMapping("/register")
    public JsonResult register(String mobile, String code, HttpSession httpSession) {
        SaSession session = StpUtil.getTokenSession();
        LambdaQueryWrapper<User> qw = Wrappers.lambdaQuery();
        qw.eq(User::getMobile, mobile);
        if (this.userService.count(qw) > 0) {
            return JsonResult.failure("此手机号已被注册，请直接用这个手机号登录或者更换手机号注册！");
        }
        if (!code.equals(httpSession.getAttribute(mobile))) {
            return JsonResult.failure("验证码错误！");
        }
        httpSession.removeAttribute(mobile);

        User user = new User();
        user.setMobile(mobile);
        user.setRealName(mobile);
        user.setInitPassword(RandomStringUtils.randomNumeric(6));
        user.setPassword(DigestUtils.sha256Hex(user.getInitPassword()));
        this.userService.save(user);

        session.set("user", this.userService.getUserVo(user.getId()));
        try {
            this.sendPasswordSms(user.getMobile(), user.getInitPassword());
        } catch (Exception e) {
            log.error("密码短信发送失败！", e);
        }
        return JsonResult.successful();
    }

    /**
     * 更新个人设置
     *
     * @param realName、email
     * @return
     */
    @PostMapping("/updateUser")
    public JsonResult updateUser(String realName, String email) {
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        user.setRealName(realName);
        user.setEmail(email);
        userService.updateById(user);
        session.set("user", user);
        return JsonResult.successful();
    }

    /**
     * 重置密码
     *
     * @param newPassword
     * @param repeatPassword
     * @param mobile
     * @param code
     * @return
     */
    @IgnoresLogin
    @PostMapping("/resetPassword")
    public JsonResult resetPassword(@RequestParam String newPassword,
                                    @RequestParam String repeatPassword,
                                    @RequestParam String mobile,
                                    @RequestParam String code, HttpSession httpSession) {
        SaSession session = StpUtil.getTokenSession();
        JsonResult result = JsonResult.instance(true);

        if (!code.equals(httpSession.getAttribute(mobile))) {
            result = JsonResult.failure("验证码错误！");
        } else if (!newPassword.equals(repeatPassword)) {
            result = JsonResult.failure("密码设置错误！");
        }

        if (result.isSuccess()) {
            LambdaQueryWrapper<User> qw = Wrappers.lambdaQuery();
            qw.eq(User::getMobile, mobile);
            User user = userService.getOne(qw);
            if (user != null) {
                user.setPassword(DigestUtils.sha256Hex(newPassword));
                user.setInitPassword("");
                userService.updateById(user);

                httpSession.removeAttribute(mobile);
            } else {
                result = JsonResult.failure("用户不存在！");
            }
        }

        return result;
    }

    /**
     * 修改密码
     *
     * @param original、newPassword
     * @return
     */
    @PostMapping("/updatePwd")
    public JsonResult updatePwd(String original, String newPassword) {
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        //核对旧密码
        User u = userService.getById(user.getId());
        if (!DigestUtils.sha256Hex(original).equals(u.getPassword())) {
            return JsonResult.failure("原密码错误!");
        }

        //更新新密码
        user.setPassword(DigestUtils.sha256Hex(newPassword));
        user.setInitPassword("");
        userService.updateById(user);
        return JsonResult.successful();
    }

    /**
     * 修改手机号码
     *
     * @param verificationCode，mobile
     * @return
     */
    @PostMapping("/changePhoneNumber")
    public JsonResult changePhoneNumber(String verificationCode, String mobile, HttpSession httpSession) {
        SaSession session = StpUtil.getTokenSession();
        //Session里获取手机号对应验证码进行比对
        if (!verificationCode.equals(httpSession.getAttribute(mobile))) {
            return JsonResult.failure("验证码错误!");
        }

        UserVo user = session.getModel("user", UserVo.class);

        //更新手机号
        user.setMobile(mobile);
        userService.updateById(user);

        session.set("user", user);
        return JsonResult.successful();
    }

    /**
     * 变更默认账套
     *
     * @param accountSetsId
     * @return
     */
    @GetMapping("/changeAccountSets")
    public JsonResult changeAccountSets(Integer accountSetsId) {
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        if (user.getAccountSetsList().stream().anyMatch(accountSets -> accountSets.getId().equals(accountSetsId))) {
            user.setAccountSetsId(accountSetsId);
            userService.updateById(user);

            session.set("user", userService.getUserVo(user.getId()));
        }
        return JsonResult.successful();
    }

    @IgnoresLogin
    @PostMapping("/selectAccountSets/{accountSetsId:\\d+}")
    public JsonResult selectAccountSets(@PathVariable Integer accountSetsId, @RequestBody UserVo user) {
        SaSession session = StpUtil.getTokenSession();
        if (user.getAccountSetsList().stream().anyMatch(accountSets -> accountSets.getId().equals(accountSetsId))) {
            user.setAccountSetsId(accountSetsId);
            userService.updateById(user);
            session.set("user", userService.getUserVo(user.getId()));
        } else {
            session.set("user", user);
        }
        return JsonResult.successful();
    }

    @PostMapping("/selectOrg")
    public JsonResult selectOrg(@RequestBody Organization org) {
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        if (user.getOrgList().stream().anyMatch(organization -> organization.getId().equals(org.getId()))) {
            user.setOrg(org);
            //更新机构对应的结账日期
            QueryWrapper query = Wrappers.query();
            query.eq("account_sets_id", user.getAccountSetsId());
            query.eq("org_id", user.getOrgId());
            user.setCheckoutList(checkoutService.list(query));
            userService.updateUserAccountSetsOrgId(user.getAccountSetsId(), user.getId(), user.getOrgId());
            session.set("user", user);
        } else {
            session.set("user", user);
        }
        return JsonResult.successful();
    }

    private void sendSmsCode(@PathVariable String mobile, String numeric) {
        log.info("smsSignature:{}", smsSignature);
        log.info("verificationCode:{}", verificationCode);
        SmsBody smsBody = new SmsBody(mobile, smsSignature, verificationCode);
        Map<String, String> params = new HashMap<>(1);
        params.put("code", numeric);
        smsBody.setTemplateParam(params);
        smsService.send(smsBody);
    }

    private void sendPasswordSms(@PathVariable String mobile, String password) {
        SmsBody smsBody = new SmsBody(mobile, smsSignature, registerCode);
        Map<String, String> params = new HashMap<>(1);
        params.put("password", password);
        smsBody.setTemplateParam(params);
        smsService.send(smsBody);
    }
}
