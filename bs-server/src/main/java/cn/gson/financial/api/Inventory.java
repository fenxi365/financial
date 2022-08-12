package cn.gson.financial.api;

import cn.gson.financial.kernel.controller.JsonResult;
import cn.hutool.cache.CacheUtil;
import cn.hutool.cache.impl.TimedCache;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/13 16:35</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
public final class Inventory {

    private final static TimedCache<String, JsonResult> timedCache = CacheUtil.newTimedCache(300000);

    private static final String LOGIN_URL = "https://shop.fenxi365.com/api/financial/login";

    private static final String SUPPLIER_LIST_URL = "https://shop.fenxi365.com/api/financial/supplier";

    private static final String MATERIAL_LIST_URL = "https://shop.fenxi365.com/api/financial/materiel";

    private static final String ORG_LIST_URL = "https://shop.fenxi365.com/api/financial/organization";

    private static final String ORDER_LIST_URL = "https://shop.fenxi365.com/api/financial/order";

    private static final String ORDER_DETAIL_LIST_URL = "https://shop.fenxi365.com/api/financial/order/detail";


//    private static final String LOGIN_URL = "http://localhost:8410/login";
//
//    private static final String SUPPLIER_LIST_URL = "http://localhost:8410/supplier/select";
//
//    private static final String MATERIAL_LIST_URL = "http://localhost:8410/materiel/select";
//
//    private static final String ORG_LIST_URL = "http://localhost:8410/organization/select";
//
//    private static final String ORDER_LIST_URL = "http://localhost:8410/order";
//
//    private static final String ORDER_DETAIL_LIST_URL = "http://localhost:8410/order/detail";


    /**
     * 登录成功，返回
     *
     * @param username
     * @param password
     * @return
     */
    public static JsonResult login(String username, String password) {
        HttpRequest request = HttpUtil.createPost(LOGIN_URL);
        request.form("username", username);
        request.form("password", password);
        request.form("device", "financial-fxy");
        HttpResponse response = request.execute();
        JsonResult result = new JSONObject(response.body()).toBean(JsonResult.class);
        if (result.isSuccess()) {
            result.setMsg(response.header("authorization"));
            return result;
        }
        throw new IllegalStateException(result.getMsg());
    }

    /**
     * 供应商
     *
     * @param
     * @return
     */
    public static JsonResult supplierList(@NonNull String token) {
        JsonResult result = timedCache.get("inventory:supplier:" + token);
        if (result != null) {
            return result;
        }
        HttpRequest request = HttpUtil.createGet(SUPPLIER_LIST_URL);
        request.header("i-m-token", token);
        HttpResponse response = request.execute();
        result = new JSONObject(response.body()).toBean(JsonResult.class);
        if (result.isSuccess()) {
            timedCache.put("inventory:supplier:" + token, result);
            return result;
        }
        throw new IllegalStateException(result.getMsg());
    }

    /**
     * 物料
     *
     * @param
     * @return
     */
    public static JsonResult materialList(@NonNull String token) {
        JsonResult result = timedCache.get("inventory:material:" + token);
        if (result != null) {
            return result;
        }
        HttpRequest request = HttpUtil.createGet(MATERIAL_LIST_URL);
        request.header("i-m-token", token);
        HttpResponse response = request.execute();
        result = new JSONObject(response.body()).toBean(JsonResult.class);
        if (result.isSuccess()) {
            timedCache.put("inventory:material:" + token, result);
            return result;
        }
        throw new IllegalStateException(result.getMsg());
    }


    /**
     * 门店
     *
     * @param token
     * @return
     */
    public static JsonResult orgList(@NonNull String token) {
        JsonResult result = timedCache.get("inventory:org:" + token);
        if (result != null) {
            return result;
        }
        HttpRequest request = HttpUtil.createGet(ORG_LIST_URL);
        request.header("i-m-token", token);
        HttpResponse response = request.execute();
        result = new JSONObject(response.body()).toBean(JsonResult.class);
        if (result.isSuccess()) {
            timedCache.put("inventory:org:" + token, result);
            return result;
        }
        throw new IllegalStateException(result.getMsg());
    }

    /**
     * 订单记录
     *
     * @param token
     * @return
     */
    public static JsonResult orderList(@NonNull String token, Map<String, String> params) {
        HttpRequest request = HttpUtil.createGet(ORDER_LIST_URL);
        request.header("i-m-token", token);
        request.form("start", params.get("start"));
        request.form("end", params.get("end"));
        request.form("type", params.get("type"));
        request.form("organizationId", params.get("organizationId"));
        request.form("page", params.get("page"));
        request.form("status", 2); //已审核
        if (params.get("pageSize") != null) {
            request.form("pageSize", params.get("pageSize"));
        }
        HttpResponse response = request.execute();
        JsonResult result = new JSONObject(response.body()).toBean(JsonResult.class);
        if (result.isSuccess()) {
            return result;
        }
        throw new IllegalStateException(result.getMsg());
    }

    public static JsonResult orderDetail(String token, Integer id, Integer entityId) {
        HttpRequest request = HttpUtil.createGet(ORDER_DETAIL_LIST_URL + "/" + id);
        JsonResult result = timedCache.get("inventory:order_detail:" + id + ":" + token);
        if (result != null) {
            return result;
        }
        request.header("i-m-token", token);
        request.form("entityId", entityId);
        HttpResponse response = request.execute();
        result = new JSONObject(response.body()).toBean(JsonResult.class);
        if (result.isSuccess()) {
            timedCache.put("inventory:order_detail:" + id + ":" + token, result);
            return result;
        }
        throw new IllegalStateException(result.getMsg());
    }
}
