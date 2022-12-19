package cn.gson.financial.interceptor;

import cn.gson.financial.annotation.IgnoresLogin;
import cn.gson.financial.annotation.Permissions;
import cn.gson.financial.kernel.common.Roles;
import cn.gson.financial.kernel.model.vo.UserVo;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.http.HttpStatus;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 权限过滤</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月07日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public class PermissionsHandlerInterceptorAdapter extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        HandlerMethod hm = (HandlerMethod) handler;
        UserVo userVo = (UserVo) session.getAttribute("user");
        if (userVo == null || hm.hasMethodAnnotation(IgnoresLogin.class)) {
            return true;
        }

        if (!hm.hasMethodAnnotation(Permissions.class)) {
            return true;
        }

        if (userVo.getRole() == null) {
            return false;
        }

        Roles role = Roles.valueOf(userVo.getRole());
        if (role.equals(Roles.Manager)) {
            return true;
        }

        //没有注解，就表示不需控制权限
        Permissions mainPermissions = hm.getBeanType().getAnnotation(Permissions.class);
        Permissions permissions = hm.getMethodAnnotation(Permissions.class);
        if (ArrayUtils.contains(permissions.value(), role)) {
            return true;
        }

        response.setStatus(HttpStatus.UNAUTHORIZED.value());
        return false;
    }
}
