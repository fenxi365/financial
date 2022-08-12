package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.AccountSets;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.mapper</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月16日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Mapper
public interface AccountSetsMapper extends BaseMapper<AccountSets> {
    int batchInsert(@Param("list") List<AccountSets> list);

    List<AccountSets> selectMyAccountSets(@Param("uid") Integer uid);
}