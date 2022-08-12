package cn.gson.financial.kernel.exception;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.exception</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月03日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public class ServiceException extends RuntimeException {

    private Integer code = 500;

    public ServiceException(String msg) {
        super(msg);
    }

    public ServiceException(String msg, Integer code) {
        super(msg);
        this.code = code;
    }

    public ServiceException(String msg, Object... objects) {
        super(String.format(msg, objects));
    }

    public Integer getCode() {
        return code;
    }
}
