package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.model.entity.VoucherDetailsAuxiliary;
import cn.gson.financial.kernel.model.mapper.VoucherDetailsAuxiliaryMapper;
import cn.gson.financial.kernel.service.VoucherDetailsAuxiliaryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.service.impl</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
public class VoucherDetailsAuxiliaryServiceImpl extends ServiceImpl<VoucherDetailsAuxiliaryMapper, VoucherDetailsAuxiliary> implements VoucherDetailsAuxiliaryService {

    @Override
    public int batchInsert(List<VoucherDetailsAuxiliary> list) {
        return baseMapper.batchInsert(list);
    }
}
