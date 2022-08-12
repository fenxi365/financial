package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.VoucherDetails;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.*;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface VoucherDetailsService extends IService<VoucherDetails> {


    int batchInsert(List<VoucherDetails> list);

    /**
     * 期初数据
     *
     * @param accountSetsId
     * @param type
     * @return
     */
    List<VoucherDetails> balanceList(Integer accountSetsId, String type, Integer orgId);

    /**
     * 期初试算平衡
     *
     * @param accountSetsId
     * @return
     */
    Map<String, Map<String, Double>> trialBalance(Integer accountSetsId,Integer orgId);

    void saveAuxiliary(Integer accountSetsId, Integer orgId, HashMap<String, Object> entity);

    List<VoucherDetails> auxiliaryList(Integer accountSetsId, String type, Integer orgId);

    /**
     * 科目会计期间的累计金额
     *
     * @param accountSetsId
     * @param codeList
     * @param currentAccountDate
     * @return
     */
    Map<String, VoucherDetails> getAggregateAmount(Integer accountSetsId, Set<String> codeList, Date currentAccountDate);

}











