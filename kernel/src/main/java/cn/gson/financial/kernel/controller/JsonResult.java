package cn.gson.financial.kernel.controller;

import lombok.Data;

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
@Data
public class JsonResult {

    private boolean success = true;

    private Integer code = 200;

    private String msg = "";

    private Object data;

    public static JsonResult instance(boolean success) {
        JsonResult result = new JsonResult();
        result.setSuccess(success);
        return result;
    }

    public static JsonResult successful() {
        return new JsonResult();
    }

    public static JsonResult successful(Object data) {
        JsonResult result = new JsonResult();
        result.setData(data);
        return result;
    }

    public static JsonResult successful(String msg, Integer code) {
        JsonResult result = new JsonResult();
        result.setMsg(msg);
        result.setCode(code);
        return result;
    }

    public static JsonResult failure() {
        JsonResult result = new JsonResult();
        result.setSuccess(false);
        result.setCode(-1);
        return result;
    }

    public static JsonResult failure(String msg) {
        JsonResult result = new JsonResult();
        result.setSuccess(false);
        result.setMsg(msg);
        result.setCode(-1);
        return result;
    }

    public static JsonResult failure(String msg, Integer code) {
        JsonResult result = new JsonResult();
        result.setSuccess(false);
        result.setMsg(msg);
        result.setCode(code);
        return result;
    }

    public JsonResult setMsg(String msg) {
        this.msg = msg;
        return this;
    }
}
