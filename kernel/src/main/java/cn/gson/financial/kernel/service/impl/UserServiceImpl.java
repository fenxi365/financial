package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.Organization;
import cn.gson.financial.kernel.model.entity.User;
import cn.gson.financial.kernel.model.entity.UserAccountSets;
import cn.gson.financial.kernel.model.mapper.UserMapper;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.apache.commons.codec.digest.DigestUtils;
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
@AllArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    private UserAccountSetsService userAccountSetsService;

    private AccountSetsService accountSetsService;

    private CheckoutService checkoutService;

    private OrganizationService organizationService;

    @Override
    public int batchInsert(List<User> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public UserVo login(@NonNull String mobile, @NonNull String password) {
        LambdaQueryWrapper<User> query = Wrappers.lambdaQuery();
        query.eq(User::getMobile, mobile);
        query.eq(User::getPassword, DigestUtils.sha256Hex(password));
        User user = this.getOne(query);
        if (user == null) {
            throw new ServiceException("账号或密码错误！");
        }
        //获取角色信息
        return getUserVo(user);
    }

    @Override
    public UserVo getUserVo(Integer userId) {
        User user = this.getById(userId);
        return getUserVo(user);

    }

    @Override
    public List<UserVo> listByAccountSetId(Integer accountSetsId) {
        return baseMapper.selectByAccountSetId(accountSetsId);
    }

    private UserVo getUserVo(User user) {
        //获取角色信息
        LambdaQueryWrapper<UserAccountSets> qw = Wrappers.lambdaQuery();
        qw.eq(UserAccountSets::getAccountSetsId, user.getAccountSetsId());
        qw.eq(UserAccountSets::getUserId, user.getId());
        UserAccountSets userAccountSets = userAccountSetsService.getOne(qw);

        UserVo userVo = new UserVo();
        if (user.getAccountSetsId() != null) {
            userVo.setAccountSets(accountSetsService.getById(user.getAccountSetsId()));

            QueryWrapper oqw = Wrappers.query();
            oqw.eq("account_sets_id", user.getAccountSetsId());
            oqw.orderByAsc("code");
            List<Organization> orgList = organizationService.list(oqw);
            userVo.setOrgList(orgList);
            if (orgList != null && orgList.size() > 0 && userAccountSets.getOrgId() == null) {
                oqw = Wrappers.query();
                oqw.eq("account_sets_id", user.getAccountSetsId());
                oqw.eq("type", 0);
                userVo.setOrg(organizationService.getBaseMapper().selectOne(oqw));
                userAccountSets.setOrgId(userVo.getOrgId());
                userAccountSetsService.update(userAccountSets, qw);
            } else {
                userVo.setOrg(organizationService.getById(userAccountSets.getOrgId()));
            }

            QueryWrapper cqw = Wrappers.query();
            cqw.eq("account_sets_id", user.getAccountSetsId());
            if (userVo.getOrgId() != null) {
                cqw.eq("org_id", userVo.getOrgId());
            }
            userVo.setCheckoutList(checkoutService.list(cqw));
            userVo.setAccountSetsList(accountSetsService.myAccountSets(user.getId()));
        }

        if (userAccountSets != null) {
            userVo.setRole(userAccountSets.getRoleType());
        }

        userVo.setId(user.getId());
        userVo.setEmail(user.getEmail());
        userVo.setMobile(user.getMobile());
        userVo.setUnionId(user.getUnionId());
        userVo.setOpenId(user.getOpenId());
        userVo.setNickname(user.getNickname());
        userVo.setAvatarUrl(user.getAvatarUrl());
        userVo.setRealName(user.getRealName());
        userVo.setAccountSetsId(user.getAccountSetsId());
        userVo.setCreateDate(user.getCreateDate());
        return userVo;
    }

    @Transactional
    public void updateUserAccountSetsOrgId(Integer accountSetsId, Integer userId, Integer orgId) {
        LambdaQueryWrapper<UserAccountSets> qw = Wrappers.lambdaQuery();
        qw.eq(UserAccountSets::getAccountSetsId, accountSetsId);
        qw.eq(UserAccountSets::getUserId, userId);
        UserAccountSets accountSets = new UserAccountSets();
        accountSets.setOrgId(orgId);
        userAccountSetsService.update(accountSets, qw);
    }
}


