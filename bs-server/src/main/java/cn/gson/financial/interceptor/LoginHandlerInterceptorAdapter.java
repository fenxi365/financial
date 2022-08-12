package cn.gson.financial.interceptor;

import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.StpUtil;
import cn.gson.financial.annotation.IgnoresLogin;
import cn.gson.financial.kernel.model.vo.UserVo;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.interceptor</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月07日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@NoArgsConstructor
@AllArgsConstructor
public class LoginHandlerInterceptorAdapter extends HandlerInterceptorAdapter {

    private String[] ignores;
    private AntPathMatcher matcher = new AntPathMatcher();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        SaSession session;
        try {
            session = StpUtil.getTokenSession();
        } catch (Exception e) {
            return true;
        }
        HandlerMethod hm = (HandlerMethod) handler;
        UserVo user = session.getModel("user", UserVo.class);
        if (user == null) {
            if (hm.hasMethodAnnotation(IgnoresLogin.class)) {
                return true;
            }

            String servletPath = request.getServletPath();
            if (this.ignores != null && this.ignores.length > 0) {
                for (String path : this.ignores) {
                    if (matcher.match(path, servletPath)) {
                        return true;
                    }
                }
            }

            response.setStatus(HttpStatus.FORBIDDEN.value());
            return false;
        }

        return true;
    }
}
