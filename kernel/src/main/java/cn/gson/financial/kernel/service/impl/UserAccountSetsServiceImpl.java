package cn.gson.financial.kernel.service.impl;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.List;
import cn.gson.financial.kernel.model.entity.UserAccountSets;
import cn.gson.financial.kernel.model.mapper.UserAccountSetsMapper;
import cn.gson.financial.kernel.service.UserAccountSetsService;
/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
public class UserAccountSetsServiceImpl extends ServiceImpl<UserAccountSetsMapper, UserAccountSets> implements UserAccountSetsService{

    @Override
    public int batchInsert(List<UserAccountSets> list) {
        return baseMapper.batchInsert(list);
    }
}
