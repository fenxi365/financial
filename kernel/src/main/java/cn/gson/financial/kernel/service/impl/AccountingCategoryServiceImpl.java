package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.AccountingCategory;
import cn.gson.financial.kernel.model.mapper.AccountingCategoryMapper;
import cn.gson.financial.kernel.service.AccountingCategoryService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

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
public class AccountingCategoryServiceImpl extends ServiceImpl<AccountingCategoryMapper, AccountingCategory> implements AccountingCategoryService {

    @Override
    public int batchInsert(List<AccountingCategory> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public boolean save(AccountingCategory entity) {
        LambdaQueryWrapper<AccountingCategory> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategory::getAccountSetsId, entity.getAccountSetsId());
        qw.eq(AccountingCategory::getName, entity.getName().trim());

        if (baseMapper.selectCount(qw) > 0) {
            throw new ServiceException("亲，提交失败啦，已经存在辅助核算类别！");
        }
        return super.save(entity);
    }

    @Override
    public boolean update(AccountingCategory entity, Wrapper<AccountingCategory> updateWrapper) {
        LambdaQueryWrapper<AccountingCategory> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategory::getAccountSetsId, entity.getAccountSetsId());
        qw.eq(AccountingCategory::getName, entity.getName().trim());
        qw.ne(AccountingCategory::getId, entity.getId());

        if (baseMapper.selectCount(qw) > 0) {
            throw new ServiceException("亲，提交失败啦，已经存在辅助核算类别！");
        }
        return super.update(entity, updateWrapper);
    }

    @Override
    public List<AccountingCategory> list(Wrapper<AccountingCategory> queryWrapper) {
        if (queryWrapper instanceof LambdaQueryWrapper) {
            ((LambdaQueryWrapper<AccountingCategory>) queryWrapper).orderByAsc(AccountingCategory::getId);
        } else {
            QueryWrapper<AccountingCategory> qw = (QueryWrapper<AccountingCategory>) queryWrapper;
            qw.orderByAsc("id");
        }

        return super.list(queryWrapper);
    }
}


