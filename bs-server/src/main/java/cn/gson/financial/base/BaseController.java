package cn.gson.financial.base;

import cn.gson.financial.kernel.model.vo.UserVo;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
public abstract class BaseController {

    protected UserVo currentUser;

    protected Integer accountSetsId;

    protected HttpSession session;

    @ModelAttribute
    public void common(HttpServletRequest request, HttpSession session) {
        this.currentUser = (UserVo) request.getSession().getAttribute("user");
        if (this.currentUser != null) {
            this.accountSetsId = this.currentUser.getAccountSetsId();
        }
        this.session = session;
    }
}
