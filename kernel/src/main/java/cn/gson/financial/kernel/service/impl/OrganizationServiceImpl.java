package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.enums.DefaultAccountingCategory;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.*;
import cn.gson.financial.kernel.model.mapper.CheckoutMapper;
import cn.gson.financial.kernel.model.mapper.OrganizationMapper;
import cn.gson.financial.kernel.model.mapper.ReportTemplateMapper;
import cn.gson.financial.kernel.model.vo.OrganizationVo;
import cn.gson.financial.kernel.service.AccountingCategoryDetailsService;
import cn.gson.financial.kernel.service.AccountingCategoryService;
import cn.gson.financial.kernel.service.OrganizationService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sourceforge.pinyin4j.PinyinHelper;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 组织机构</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    :2022年02月13日</li>
 * <li>@author     :李泽龙</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Service
@AllArgsConstructor
public class OrganizationServiceImpl extends ServiceImpl<OrganizationMapper, Organization> implements OrganizationService {

    private final CheckoutMapper checkoutMapper;

    private final ReportTemplateMapper templateMapper;

    private final AccountingCategoryDetailsService accountingCategoryDetailsService;

    private final AccountingCategoryService accountingCategoryService;

    public List<OrganizationVo> listVo(Wrapper<Organization> queryWrapper) {
        return baseMapper.selectOrganizationVo(queryWrapper);
    }

    @Override
    public boolean save(Organization entity) {
        LambdaQueryWrapper<Organization> qw = Wrappers.lambdaQuery();
        qw.and(dqw -> dqw.eq(Organization::getCode, entity.getCode()).or().eq(Organization::getName, entity.getName()));
        qw.eq(Organization::getCreatorId, entity.getCreatorId());

        if (this.count(qw) > 0) {
            throw new ServiceException("名称或编码已经存在！");
        }
        entity.setCurrentAccountDate(entity.getEnableDate());

        LambdaQueryWrapper<ReportTemplate> tqw = Wrappers.lambdaQuery();
        tqw.eq(ReportTemplate::getAccountSetsId, entity.getAccountSetsId());
        tqw.eq(ReportTemplate::getIsDefault, true);
        //绑定报表
        templateMapper.selectList(tqw).forEach(template -> {
            //{0: "利润表", 1: "资产报表",2:"现金流量表",
            if (template.getType() == 0) {
                entity.setProfitTemplateId(template.getId());
            } else if (template.getType() == 1) {
                entity.setDebtTemplateId(template.getId());
            } else if (template.getType() == 2) {
                entity.setCashTemplateId(template.getId());
            }
        });
        boolean rs = super.save(entity);
        if (rs) {
            //初始化结转状态
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(entity.getEnableDate());
            Checkout checkout = new Checkout();
            checkout.setAccountSetsId(entity.getAccountSetsId());
            checkout.setCheckYear(calendar.get(Calendar.YEAR));
            checkout.setCheckMonth(calendar.get(Calendar.MONDAY) + 1);
            checkout.setOrgId(entity.getId());
            checkoutMapper.insert(checkout);
        }

        LambdaQueryWrapper<AccountingCategory> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(AccountingCategory::getAccountSetsId, entity.getAccountSetsId());
        wrapper.eq(AccountingCategory::getName, DefaultAccountingCategory.核算机构.name());

        AccountingCategory category = accountingCategoryService.getOne(wrapper);

        AccountingCategoryDetails accountingCategoryDetails = new AccountingCategoryDetails();
        accountingCategoryDetails.setCode(entity.getCode());
        accountingCategoryDetails.setName(entity.getName());
        accountingCategoryDetails.setEnable(true);
        accountingCategoryDetails.setAccountingCategoryId(category.getId());
        accountingCategoryDetails.setCusColumn0(getPinYinHeadChar(entity.getName()));
        accountingCategoryDetails.setCusColumn1(new String[]{"总公司", "门店", "部门"}[entity.getType()]);

        accountingCategoryDetailsService.save(accountingCategoryDetails);

        return rs;
    }

    @Override
    public boolean remove(Wrapper<Organization> wrapper) {
        return super.remove(wrapper);
    }

    @Override
    @Transactional
    public void updateEntityId(List<Organization> entity) {
        entity.forEach(org -> {
            LambdaQueryWrapper<Organization> wrapper = Wrappers.lambdaQuery();
            wrapper.eq(Organization::getId, org.getId());
            Organization updateOrg = new Organization();
            if (org.getEntityId() != null) {
                updateOrg.setEntityId(org.getEntityId());
                super.update(updateOrg, wrapper);
            }
//            else {
//                Organization old = this.getById(org.getId());
//                old.setEntityId(null);
//                this.getBaseMapper().updateById(old);
//            }
        });
    }

    @Override
    @Transactional
    public boolean update(Organization entity, Wrapper<Organization> updateWrapper) {
        Organization old = this.getById(entity.getId());

        //如果修改了机构启用日期，需要同步更新
        if (!DateFormatUtils.format(old.getEnableDate(), "yyyyMM").equals(DateFormatUtils.format(entity.getEnableDate(), "yyyyMM"))) {
            LambdaQueryWrapper<Checkout> cqw = Wrappers.lambdaQuery();
            cqw.eq(Checkout::getAccountSetsId, entity.getId());
            cqw.eq(Checkout::getCheckYear, DateFormatUtils.format(old.getEnableDate(), "yyyy"));
            cqw.eq(Checkout::getCheckMonth, DateFormatUtils.format(old.getEnableDate(), "M"));
            cqw.eq(Checkout::getOrgId, old.getId());

            Checkout checkout = this.checkoutMapper.selectOne(cqw);
            checkout.setCheckYear(Integer.parseInt(DateFormatUtils.format(entity.getEnableDate(), "yyyy")));
            checkout.setCheckMonth(Integer.parseInt(DateFormatUtils.format(entity.getEnableDate(), "M")));
            this.checkoutMapper.updateById(checkout);
            entity.setEnableDate(entity.getEnableDate());
        }


        LambdaQueryWrapper<AccountingCategoryDetails> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(AccountingCategoryDetails::getCode, entity.getCode());

        AccountingCategoryDetails categoryDetails = accountingCategoryDetailsService.getOne(wrapper);
        categoryDetails.setCode(entity.getCode());
        categoryDetails.setName(entity.getName());
        categoryDetails.setCusColumn0(getPinYinHeadChar(entity.getName()));
        categoryDetails.setCusColumn1(new String[]{"总公司", "门店", "部门"}[entity.getType()]);
        accountingCategoryDetailsService.updateById(categoryDetails);

        return super.update(entity, updateWrapper);
    }

    public static String getPinYinHeadChar(String str) {
        String convert = "";
        if (str == null || str.length() == 0) {
            return convert;
        }
        for (int j = 0; j < str.length(); j++) {
            char word = str.charAt(j);
            // 提取汉字的首字母
            String[] pinyinArray = PinyinHelper.toHanyuPinyinStringArray(word);
            if (pinyinArray != null) {
                convert += pinyinArray[0].charAt(0);
            } else {
                convert += word;
            }
        }
        return convert.toLowerCase();
    }
}
