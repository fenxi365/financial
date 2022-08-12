package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.VoucherWord;
import cn.gson.financial.kernel.model.mapper.VoucherWordMapper;
import cn.gson.financial.kernel.service.VoucherWordService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
public class VoucherWordServiceImpl extends ServiceImpl<VoucherWordMapper, VoucherWord> implements VoucherWordService {

    @Override
    public int batchInsert(List<VoucherWord> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    @Transactional
    public boolean save(VoucherWord entity) {
        //判断是否重复
        LambdaQueryWrapper<VoucherWord> query = Wrappers.lambdaQuery();
        query.eq(VoucherWord::getWord, entity.getWord().trim());
        query.eq(VoucherWord::getAccountSetsId, entity.getAccountSetsId());

        if (this.count(query) > 0) {
            throw new ServiceException("亲，保存失败啦！凭证字【%s】已经存在！", entity.getWord());
        }
        boolean rs = super.save(entity);
        if (rs) {
            this.updateDefault(entity);
        }
        return rs;
    }

    @Override
    @Transactional
    public boolean update(VoucherWord entity, Wrapper<VoucherWord> updateWrapper) {
        boolean rs = baseMapper.update(entity, updateWrapper) > 0;
        if (rs) {
            this.updateDefault(entity);
        }
        return rs;
    }

    @Override
    public boolean remove(Wrapper<VoucherWord> wrapper) {
        VoucherWord word = this.getOne(wrapper);
        if (word.getIsDefault()) {
            throw new ServiceException("默认凭证字不能被删除！");
        }
        return super.remove(wrapper);
    }

    /**
     * 如果新增为默认，则把其他的都设置为非默认
     *
     * @param entity
     */
    private void updateDefault(VoucherWord entity) {
        LambdaQueryWrapper<VoucherWord> query;
        if (entity.getIsDefault()) {
            query = Wrappers.lambdaQuery();
            query.ne(VoucherWord::getId, entity.getId());
            query.eq(VoucherWord::getAccountSetsId, entity.getAccountSetsId());

            VoucherWord vw = new VoucherWord();
            vw.setIsDefault(false);
            baseMapper.update(vw, query);
        }
    }
}

