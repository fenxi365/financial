package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.Checkout;
import cn.gson.financial.kernel.model.vo.UserVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月23日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface CheckoutService extends IService<Checkout> {


    int batchInsert(List<Checkout> list);

    /**
     * 期初检查
     *
     * @param accountSetsId
     * @return
     */
    boolean initialCheck(Integer accountSetsId);

    /**
     * 期末检查
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    boolean finalCheck(Integer accountSetsId, Integer year, Integer month);

    /**
     * 报表检查
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    Map<String, Object> reportCheck(Integer accountSetsId, Integer year, Integer month);

    /**
     * 断号检查
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    boolean brokenCheck(Integer accountSetsId, Integer year, Integer month);

    /**
     * 结账
     *
     * @param user
     * @param year
     * @param month
     * @return
     */
    boolean invoicing(UserVo user, Integer year, Integer month);

    /**
     * 反结账
     *
     * @param currentUser
     * @param year
     * @param month
     * @return
     */
    boolean unCheck(UserVo currentUser, Integer year, Integer month);
}

