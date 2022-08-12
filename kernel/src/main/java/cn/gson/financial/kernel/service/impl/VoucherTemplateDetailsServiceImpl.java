package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.model.entity.VoucherTemplateDetails;
import cn.gson.financial.kernel.model.mapper.VoucherTemplateDetailsMapper;
import cn.gson.financial.kernel.service.VoucherTemplateDetailsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月03日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
public class VoucherTemplateDetailsServiceImpl extends ServiceImpl<VoucherTemplateDetailsMapper, VoucherTemplateDetails> implements VoucherTemplateDetailsService {

    @Override
    public int batchInsert(List<VoucherTemplateDetails> list) {
        return baseMapper.batchInsert(list);
    }
}



