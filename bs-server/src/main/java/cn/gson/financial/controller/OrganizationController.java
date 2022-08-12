package cn.gson.financial.controller;

import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.StpUtil;
import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Organization;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.vo.OrganizationVo;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.OrganizationService;
import cn.gson.financial.kernel.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 组织机构</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022年02月13日</li>
 * <li>@author     : 李泽龙</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@RestController
@RequestMapping("/organization")
public class OrganizationController extends BaseCrudController<OrganizationService, Organization> {

    @Autowired
    private VoucherService voucherService;

    @Override
    public JsonResult list(@RequestParam Map<String, String> params) {
        QueryWrapper qw = new QueryWrapper<>();
        this.setQwAccountSetsId(qw);
        qw.allEq(params);
        qw.orderByAsc("code");
        return JsonResult.successful(service.list(qw));
    }

    @Override
    public JsonResult delete(@PathVariable Long id) {
        QueryWrapper qw = new QueryWrapper<>();
        qw.eq("parent_id", id);
        if (service.list(qw).size() > 0) {
            return JsonResult.failure("请选删除下级~");
        }
        service.getBaseMapper().deleteById(id);
        return JsonResult.successful();
    }

    @PostMapping("/mapping")
    public JsonResult mapping(@RequestBody List<Organization> entity) {
        service.updateEntityId(entity);
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        QueryWrapper oqw = Wrappers.query();
        oqw.eq("account_sets_id", user.getAccountSetsId());
        oqw.orderByAsc("code");
        user.setOrgList(service.list(oqw));
        session.set("user", user);
        return JsonResult.successful();
    }

    @Override
    public JsonResult save(@RequestBody Organization entity) {
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        entity.setAccountSetsId(user.getAccountSetsId());
        entity.setCreatorId(user.getId());
        JsonResult result = super.save(entity);
        result.setData(entity);
        QueryWrapper oqw = Wrappers.query();
        oqw.eq("account_sets_id", user.getAccountSetsId());
        oqw.orderByAsc("code");
        user.setOrgList(service.list(oqw));
        session.set("user", user);
        return result;
    }

    @Override
    public JsonResult update(@RequestBody Organization entity) {
        QueryWrapper qw = Wrappers.query();
        qw.eq("id", entity.getId());
        service.update(entity, qw);
        SaSession session = StpUtil.getTokenSession();
        UserVo user = session.getModel("user", UserVo.class);
        QueryWrapper oqw = Wrappers.query();
        oqw.eq("account_sets_id", user.getAccountSetsId());
        oqw.orderByAsc("code");
        user.setOrgList(service.list(oqw));
        if (entity.getId() == user.getOrgId()) {
            Organization org = user.getOrg();
            org.setName(entity.getName());
            org.setCurrentAccountDate(entity.getCurrentAccountDate());
            user.setOrg(org);
        }
        session.set("user", user);
        return JsonResult.successful();
    }

    /**
     * 检查组织是否已有凭证
     *
     * @param orgId 组织 ID
     * @return
     */
    @GetMapping("/checkUse/{orgId:\\d+}")
    public JsonResult checkUse(@PathVariable Integer orgId) {
        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getOrgId, orgId);
        return JsonResult.successful(voucherService.count(qw) > 0);
    }


    private void recursiveParent(List<OrganizationVo> organizations, Integer parentId) {
        QueryWrapper qw = Wrappers.query();
        this.setQwAccountSetsId(qw);
        qw.eq("id", parentId);
        Organization parent = this.service.getOne(qw);
        OrganizationVo vo = new OrganizationVo();
        BeanUtils.copyProperties(parent, vo);
        organizations.add(vo);
    }

    private void recursiveChildren(Map<Integer, OrganizationVo> organizationMap, Organization organization, Integer parentId) {
        Organization parent = organizationMap.get(parentId);
        if (parent != null) {
            organization.setName(parent.getName() + "-" + organization.getName());
        }
    }

}
