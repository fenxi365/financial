package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.model.entity.VoucherTemplate;
import cn.gson.financial.kernel.model.entity.VoucherTemplateDetails;
import cn.gson.financial.kernel.model.mapper.VoucherTemplateDetailsMapper;
import cn.gson.financial.kernel.model.mapper.VoucherTemplateMapper;
import cn.gson.financial.kernel.service.VoucherTemplateService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

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
@AllArgsConstructor
public class VoucherTemplateServiceImpl extends ServiceImpl<VoucherTemplateMapper, VoucherTemplate> implements VoucherTemplateService {

    private VoucherTemplateDetailsMapper detailsMapper;

    @Override
    public int batchInsert(List<VoucherTemplate> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public List<VoucherTemplate> list(Wrapper<VoucherTemplate> queryWrapper) {
        return baseMapper.selectVoucherTemplate(queryWrapper);
    }

    @Override
    @Transactional
    public boolean save(VoucherTemplate entity) {
        boolean rs = super.save(entity);

        AtomicReference<Double> debitAmount = new AtomicReference<>((double) 0);
        AtomicReference<Double> creditAmount = new AtomicReference<>((double) 0);
        if (rs) {
            entity.getDetails().forEach(vd -> {
                vd.setVoucherTemplateId(entity.getId());
                vd.setAccountSetsId(entity.getAccountSetsId());
                if (vd.getDebitAmount() != null) {
                    debitAmount.updateAndGet(v -> v + vd.getDebitAmount());
                }
                if (vd.getCreditAmount() != null) {
                    creditAmount.updateAndGet(v -> v + vd.getCreditAmount());
                }
            });

            detailsMapper.batchInsert(entity.getDetails());

            //更新总和
            entity.setCreditAmount(creditAmount.get());
            entity.setDebitAmount(debitAmount.get());
            baseMapper.updateById(entity);
        }


        return rs;
    }

    @Override
    @Transactional
    public boolean update(VoucherTemplate entity, Wrapper<VoucherTemplate> updateWrapper) {
        boolean rs = super.update(entity, updateWrapper);

        //删除原有明细
        LambdaQueryWrapper<VoucherTemplateDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherTemplateDetails::getVoucherTemplateId, entity.getId());
        detailsMapper.delete(qw);

        AtomicReference<Double> debitAmount = new AtomicReference<>((double) 0);
        AtomicReference<Double> creditAmount = new AtomicReference<>((double) 0);
        if (rs) {
            entity.getDetails().forEach(vd -> {
                vd.setVoucherTemplateId(entity.getId());
                vd.setAccountSetsId(entity.getAccountSetsId());
                if (vd.getDebitAmount() != null) {
                    debitAmount.updateAndGet(v -> v + vd.getDebitAmount());
                }
                if (vd.getCreditAmount() != null) {
                    creditAmount.updateAndGet(v -> v + vd.getCreditAmount());
                }
            });

            detailsMapper.batchInsert(entity.getDetails());

            //更新总和
            entity.setCreditAmount(creditAmount.get());
            entity.setDebitAmount(debitAmount.get());
            baseMapper.updateById(entity);
        }


        return rs;
    }

    @Override
    public VoucherTemplate getOne(Wrapper<VoucherTemplate> queryWrapper) {
        VoucherTemplate voucherTemplate = super.getOne(queryWrapper);
        LambdaQueryWrapper<VoucherTemplateDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherTemplateDetails::getVoucherTemplateId, voucherTemplate.getId());
        voucherTemplate.setDetails(detailsMapper.selectList(qw));
        return voucherTemplate;
    }

    @Override
    @Transactional
    public boolean remove(Wrapper<VoucherTemplate> wrapper) {
        VoucherTemplate voucherTemplate = baseMapper.selectOne(wrapper);
        LambdaQueryWrapper<VoucherTemplateDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherTemplateDetails::getVoucherTemplateId, voucherTemplate.getId());
        detailsMapper.delete(qw);

        return baseMapper.delete(wrapper) > 0;
    }
}
