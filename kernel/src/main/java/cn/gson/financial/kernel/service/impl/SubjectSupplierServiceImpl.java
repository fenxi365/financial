package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.model.entity.SubjectSupplier;
import cn.gson.financial.kernel.model.mapper.SubjectSupplierMapper;
import cn.gson.financial.kernel.model.vo.SubjectSupplierlVo;
import cn.gson.financial.kernel.service.SubjectSupplierService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/17 9:43</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Service
@AllArgsConstructor
public class SubjectSupplierServiceImpl extends ServiceImpl<SubjectSupplierMapper, SubjectSupplier> implements SubjectSupplierService {

    @Override
    @Transactional
    public void saveAll(List<SubjectSupplier> entity, Integer accountSetsId) {
        LambdaQueryWrapper<SubjectSupplier> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(SubjectSupplier::getAccountSetsId, accountSetsId);
        this.baseMapper.delete(wrapper);
        entity.forEach(val->{
            val.setAccountSetsId(accountSetsId);
            val.setSupplierId(val.getId());
            val.setId(null);
        });
        this.saveBatch(entity);
    }

    @Override
    public List<SubjectSupplierlVo> supplierSubject(Integer accountSetsId) {
        return baseMapper.selectSubjectSupplierlVo(accountSetsId);
    }
}
