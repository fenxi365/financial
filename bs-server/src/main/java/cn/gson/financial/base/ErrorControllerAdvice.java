package cn.gson.financial.base;

import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.exception.ServiceException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.base</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月07日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@ControllerAdvice
@Slf4j
public class ErrorControllerAdvice {

    /**
     * 服务异常
     *
     * @param throwable
     * @return
     */
    @ExceptionHandler(ServiceException.class)
    @ResponseStatus(HttpStatus.EXPECTATION_FAILED)
    @ResponseBody
    public JsonResult exception(final ServiceException throwable) {
        log.warn("ServiceException warn", throwable);
        return JsonResult.failure(throwable.getMessage(), throwable.getCode());
    }

    /**
     * 统一其他异常
     *
     * @param throwable
     * @return
     */
    @ExceptionHandler(Throwable.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ResponseBody
    public JsonResult exception(final Throwable throwable) {
        log.error("Throwable Error", throwable);
        return JsonResult.failure("操作被禁止或发生错误！");
    }
}
