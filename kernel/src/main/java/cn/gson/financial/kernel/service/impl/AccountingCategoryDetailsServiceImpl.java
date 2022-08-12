package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.AccountingCategory;
import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.model.mapper.AccountingCategoryDetailsMapper;
import cn.gson.financial.kernel.model.mapper.AccountingCategoryMapper;
import cn.gson.financial.kernel.service.AccountingCategoryDetailsService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

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
@AllArgsConstructor
public class AccountingCategoryDetailsServiceImpl extends ServiceImpl<AccountingCategoryDetailsMapper, AccountingCategoryDetails> implements AccountingCategoryDetailsService {

    private AccountingCategoryMapper categoryMapper;

    @Override
    public int batchInsert(List<AccountingCategoryDetails> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    @Transactional
    public void clear(Integer accountingCategoryId, Integer accountSetsId) {
        AccountingCategory category = categoryMapper.selectById(accountingCategoryId);
        if (!category.getAccountSetsId().equals(accountSetsId)) {
            throw new ServiceException("亲，您不能做清空操作！");
        }
        LambdaQueryWrapper<AccountingCategoryDetails> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategoryDetails::getAccountingCategoryId, accountingCategoryId);

        baseMapper.delete(qw);

        //设置为可以编辑
        AccountingCategory ac = new AccountingCategory();
        ac.setId(accountingCategoryId);
        ac.setCanEdit(true);
        categoryMapper.updateById(ac);
    }

    /**
     * @param accountSetsId
     * @param value
     * @return
     */
    @Override
    public List<AccountingCategoryDetails> getByCodeSet(String name, Integer accountSetsId, Set<String> value) {
        return baseMapper.selectByCodeSet(name, accountSetsId, value);
    }

    /**
     * 导入数据
     *
     * @param categoryId
     * @param detailsMap
     * @return
     */
    @Override
    @Transactional
    public Map<String, Integer> importData(Integer categoryId, Map<String, AccountingCategoryDetails> detailsMap) {
        Map<String, Integer> result = new HashMap<>(4);
        result.put("total", detailsMap.size());
        //盘点是否已经在系统存在
        LambdaQueryWrapper<AccountingCategoryDetails> qwd = Wrappers.lambdaQuery();
        qwd.eq(AccountingCategoryDetails::getAccountingCategoryId, categoryId);
        qwd.in(AccountingCategoryDetails::getCode, detailsMap.keySet());
        //已存在的数据
        List<AccountingCategoryDetails> existing = this.list(qwd);
        result.put("updated", existing.size());
        List<AccountingCategoryDetails> updated = new ArrayList<>(existing.size());
        for (AccountingCategoryDetails categoryDetails : existing) {
            AccountingCategoryDetails d = detailsMap.get(categoryDetails.getCode());
            d.setId(categoryDetails.getId());
            updated.add(d);
        }

        //新插入的
        List<AccountingCategoryDetails> inserted = detailsMap.values().stream().filter(d -> d.getId() == null).collect(Collectors.toList());
        result.put("inserted", inserted.size());

        if (!inserted.isEmpty()) {
            this.batchInsert(inserted);
        }

        if (!updated.isEmpty()) {
            this.updateBatchById(updated);
        }

        return result;
    }

    @Override
    @Transactional
    public boolean save(AccountingCategoryDetails entity) {
        LambdaQueryWrapper<AccountingCategoryDetails> qw = Wrappers.lambdaQuery();
        qw.eq(AccountingCategoryDetails::getAccountingCategoryId, entity.getAccountingCategoryId());
        qw.eq(AccountingCategoryDetails::getCode, entity.getCode().trim());

        if (baseMapper.selectCount(qw) > 0) {
            throw new ServiceException("亲，提交失败啦，编码已经存在！");
        }
        boolean rs = super.save(entity);
        if (rs) {
            //设置类别为不能编辑
            AccountingCategory ac = new AccountingCategory();
            ac.setId(entity.getAccountingCategoryId());
            ac.setCanEdit(false);
            categoryMapper.updateById(ac);
        }
        return rs;
    }

    @Override
    @Transactional
    public boolean remove(Wrapper<AccountingCategoryDetails> wrapper) {
        AccountingCategoryDetails details = this.getOne(wrapper);
        boolean rs = super.remove(wrapper);
        if (rs) {
            LambdaQueryWrapper<AccountingCategoryDetails> qw = Wrappers.lambdaQuery();
            qw.eq(AccountingCategoryDetails::getAccountingCategoryId, details.getAccountingCategoryId());

            AccountingCategory ac = new AccountingCategory();
            ac.setId(details.getAccountingCategoryId());
            ac.setCanEdit(this.count(qw) == 0);
            categoryMapper.updateById(ac);
        }
        return rs;
    }

    @Override
    public IPage<AccountingCategoryDetails> page(IPage<AccountingCategoryDetails> page, Wrapper<AccountingCategoryDetails> queryWrapper) {
        LambdaQueryWrapper<AccountingCategoryDetails> qw = (LambdaQueryWrapper<AccountingCategoryDetails>) queryWrapper;
        qw.orderByDesc(AccountingCategoryDetails::getId);
        return super.page(page, queryWrapper);
    }
}

