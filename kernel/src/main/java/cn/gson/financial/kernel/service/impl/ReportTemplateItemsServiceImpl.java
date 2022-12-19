package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.model.entity.ReportTemplateItems;
import cn.gson.financial.kernel.model.entity.ReportTemplateItemsFormula;
import cn.gson.financial.kernel.model.mapper.ReportTemplateItemsFormulaMapper;
import cn.gson.financial.kernel.model.mapper.ReportTemplateItemsMapper;
import cn.gson.financial.kernel.service.ReportTemplateItemsService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.service.impl</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
@AllArgsConstructor
public class ReportTemplateItemsServiceImpl extends ServiceImpl<ReportTemplateItemsMapper, ReportTemplateItems> implements ReportTemplateItemsService {

    private ReportTemplateItemsFormulaMapper formulaMapper;

    @Override
    public int batchInsert(List<ReportTemplateItems> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public List<ReportTemplateItems> list(Wrapper<ReportTemplateItems> queryWrapper) {
        QueryWrapper<ReportTemplateItems> qw = (QueryWrapper) queryWrapper;
        qw.orderByAsc("pos");
        return super.list(qw);
    }

    @Override
    public boolean save(ReportTemplateItems entity) {
        if (entity.getIsClassified() != null && entity.getIsClassified()) {
            entity.setLineNum(null);
            entity.setSources(null);
            entity.setType(null);
        }
        return super.save(entity);
    }

    /**
     * 保存公式信息
     *
     * @param formulas
     * @param accountSetsId
     */
    @Override
    @Transactional
    public void saveFormula(Integer templateItemsId, List<ReportTemplateItemsFormula> formulas, Integer accountSetsId) {
        LambdaQueryWrapper<ReportTemplateItemsFormula> qw = Wrappers.lambdaQuery();
        qw.eq(ReportTemplateItemsFormula::getAccountSetsId, accountSetsId);
        qw.eq(ReportTemplateItemsFormula::getTemplateItemsId, templateItemsId);
        formulaMapper.delete(qw);

        if (formulas != null && formulas.size() > 0) {
            formulas.forEach(f -> f.setAccountSetsId(accountSetsId));
            formulaMapper.batchInsert(formulas);
        }
    }

    @Override
    public boolean update(ReportTemplateItems entity, Wrapper<ReportTemplateItems> updateWrapper) {
        if (entity.getIsClassified() != null && entity.getIsClassified()) {
            entity.setLineNum(null);
            entity.setSources(null);
            entity.setType(null);
        }

        ReportTemplateItems templateItems = baseMapper.selectOne(updateWrapper);
        if (!templateItems.getSources().equals(entity.getSources())) {
            LambdaQueryWrapper<ReportTemplateItemsFormula> qw = Wrappers.lambdaQuery();
            qw.eq(ReportTemplateItemsFormula::getTemplateItemsId, entity.getId());
            formulaMapper.delete(qw);
        }
        return super.update(entity, updateWrapper);
    }
}




