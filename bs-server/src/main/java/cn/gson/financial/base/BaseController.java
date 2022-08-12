package cn.gson.financial.base;

import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.StpUtil;
import cn.gson.financial.kernel.model.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
public abstract class BaseController {

    protected ThreadLocal<UserVo> currentUser = new ThreadLocal<>();

    protected ThreadLocal<Integer> accountSetsId = new ThreadLocal<>();

    protected ThreadLocal<SaSession> session = new ThreadLocal<>();

    @ModelAttribute
    public void common(HttpServletRequest request) {
        try {
            this.session.set(StpUtil.getTokenSession());
            this.currentUser.set(this.session.get().getModel("user", UserVo.class));
        } catch (Exception e) {
            log.error("session error:{}", e.getMessage());
        }

        if (this.currentUser.get() != null) {
            this.accountSetsId.set(this.currentUser.get().getAccountSetsId());
        }
    }
}
