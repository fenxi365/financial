package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.exception.ServiceException;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;


import cn.gson.financial.kernel.model.mapper.CurrencyMapper;
import cn.gson.financial.kernel.model.entity.Currency;
import cn.gson.financial.kernel.service.CurrencyService;

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
@Service
public class CurrencyServiceImpl extends ServiceImpl<CurrencyMapper, Currency> implements CurrencyService {

    @Override
    public int batchInsert(List<Currency> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public boolean save(Currency entity) {
        LambdaQueryWrapper<Currency> qw = Wrappers.lambdaQuery();
        qw.eq(Currency::getAccountSetsId, entity.getAccountSetsId());
        qw.eq(Currency::getCode, entity.getCode());
        if (this.count(qw) > 0) {
            throw new ServiceException("币别编码已经存在！");
        }
        return super.save(entity);
    }

    @Override
    public boolean remove(Wrapper<Currency> wrapper) {
        Currency currency = this.getOne(wrapper);
        if (currency.getLocalCurrency()) {
            throw new ServiceException("本位币不能删除！");
        }
        return super.remove(wrapper);
    }
}


