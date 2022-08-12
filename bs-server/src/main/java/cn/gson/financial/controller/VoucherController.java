package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.common.VoucherExcelUtils;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.service.UserService;
import cn.gson.financial.kernel.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@RestController
@RequestMapping("/voucher")
public class VoucherController extends BaseCrudController<VoucherService, Voucher> {

    String[] defaultSummary = new String[]{"提现", "利息收入", "利息收入", "支付银行手续费", "报销销售人员的业务招待费", "购入固定资产", "支付货款"};

    @Autowired
    private UserService userService;

    @Autowired
    private VoucherExcelUtils excelUtils;

    @GetMapping("code")
    public JsonResult loadCode(String word, Date currentAccountDate, Integer orgId) {
        int code = this.service.loadCode(this.accountSetsId.get(), word, currentAccountDate, orgId);
        return JsonResult.successful(code);
    }

    /**
     * 期末结转，结转金额
     *
     * @param years 期间年
     * @param month 期间月
     * @param code  科目编码
     * @return
     */
    @PostMapping("carryForwardMoney")
    public JsonResult carryForwardMoney(Integer years, Integer month, String[] code, Integer orgId) {
        Map<String, VoucherDetails> detailsMap = this.service.carryForwardMoney(this.accountSetsId.get(), years, month, code, orgId);
        return JsonResult.successful(detailsMap);
    }

    /**
     * 断号整理
     *
     * @param year  期间年
     * @param month 期间月
     * @return
     */
    @GetMapping("finishingOffNo")
    public JsonResult finishingOffNo(Integer year, Integer month, Integer orgId) {
        this.service.finishingOffNo(this.accountSetsId.get(), year, month, orgId);
        return JsonResult.successful();
    }

    /**
     * 批量删除
     *
     * @param checked 凭证ID
     * @return
     */
    @PostMapping("batchDelete")
    public JsonResult batchDelete(Integer[] checked, Integer year, Integer month, Integer orgId) {
        this.service.batchDelete(this.accountSetsId.get(), checked, year, month, orgId);
        return JsonResult.successful();
    }

    /**
     * 批量审核
     *
     * @param checked 凭证ID
     * @return
     */
    @PostMapping("audit")
    public JsonResult audit(Integer[] checked, Integer year, Integer month, Integer orgId) {
        this.service.audit(this.accountSetsId.get(), checked, this.currentUser.get(), year, month, orgId);
        return JsonResult.successful();
    }

    /**
     * 批量反审核
     *
     * @param checked 凭证ID
     * @return
     */
    @PostMapping("cancelAudit")
    public JsonResult cancelAudit(Integer[] checked, Integer year, Integer month, Integer orgId) {
        this.service.cancelAudit(this.accountSetsId.get(), checked, this.currentUser.get(), year, month, orgId);
        return JsonResult.successful();
    }

    /**
     * 上一条
     *
     * @param currentId 凭证ID
     * @return
     */
    @GetMapping("beforeId")
    public JsonResult beforeId(Integer currentId, Integer orgId) {
        Integer id = this.service.getBeforeId(this.accountSetsId.get(), currentId, orgId);
        return JsonResult.successful(id);
    }

    /**
     * 下一条
     *
     * @param currentId 凭证ID
     * @return
     */
    @GetMapping("nextId")
    public JsonResult nextId(Integer currentId, Integer orgId) {
        Integer id = this.service.getNextId(this.accountSetsId.get(), currentId, orgId);
        return JsonResult.successful(id);
    }

    @Override
    public JsonResult save(@RequestBody Voucher entity) {
        JsonResult result = super.save(entity);
        if (result.isSuccess()) {
            DateFormat sdf = new SimpleDateFormat("yyyyMM");
            if (!sdf.format(this.currentUser.get().getAccountSets().getCurrentAccountDate()).equals(entity.getVoucherDate())) {
                this.session.get().set("user", this.userService.getUserVo(this.currentUser.get().getId()));
            }
        }
        result.setData(entity);
        return result;
    }

    @GetMapping("summary")
    public JsonResult summary() {
        List<String> summary = this.service.getTopSummary(this.accountSetsId.get(), this.currentUser.get().getOrgId());
        summary = summary.stream().map(String::trim).collect(Collectors.toList());
        for (String s : defaultSummary) {
            if (!summary.contains(s)) {
                summary.add(s);
            }
        }
        return JsonResult.successful(summary);
    }

    @PostMapping("/import")
    public JsonResult importVoucher(@RequestParam("file") MultipartFile multipartFile, Integer orgId) {
        try {
            List<Voucher> voucherList = excelUtils.readExcel(multipartFile.getOriginalFilename(), multipartFile.getInputStream(), this.currentUser.get(), orgId);
            Date date = this.service.importVoucher(voucherList, this.currentUser.get().getAccountSets(), orgId);
            this.session.get().set("user", this.userService.getUserVo(this.currentUser.get().getId()));
            return JsonResult.successful(date);
        } catch (ServiceException e) {
            return JsonResult.failure(e.getMessage());
        } catch (Exception e) {
            log.error("导入失败", e);
            throw new ServiceException("导入失败~", e);
        }
    }

    @GetMapping("download")
    public void exportVoucher(HttpServletResponse response, Integer orgId) {
        try {
            LambdaQueryWrapper<Voucher> qwd = Wrappers.lambdaQuery();
            qwd.eq(Voucher::getAccountSetsId, this.accountSetsId.get());
            qwd.eq(Voucher::getOrgId, orgId);
            qwd.orderByAsc(Voucher::getVoucherDate);
            List<Voucher> list = service.exportVoucher(qwd);
            excelUtils.exportExcel(list, this.currentUser.get(), response);
        } catch (ServiceException e) {
            log.error("凭证导出失败", e);
        } catch (Exception e) {
            log.error("凭证导出失败", e);
            throw new ServiceException("凭证导出失败~", e);
        }
    }
}
