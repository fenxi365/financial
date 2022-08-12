package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;
import java.util.Set;

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
public interface AccountingCategoryDetailsService extends IService<AccountingCategoryDetails> {


    int batchInsert(List<AccountingCategoryDetails> list);

    /**
     * 情况辅助数据
     *
     * @param accountingCategoryId 类别 id
     * @param accountSetsId        账套 id
     */
    void clear(Integer accountingCategoryId, Integer accountSetsId);

    /**
     * @param name
     * @param accountSetsId
     * @param value
     * @return
     */
    List<AccountingCategoryDetails> getByCodeSet(String name, Integer accountSetsId, Set<String> value);

    /**
     * 导入数据
     *
     * @param categoryId
     * @param detailsMap
     * @return
     */
    Map<String, Integer> importData(Integer categoryId, Map<String, AccountingCategoryDetails> detailsMap);
}

