package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.common.VoucherExcelUtils;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.service.UserService;
import cn.gson.financial.kernel.service.VoucherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public JsonResult loadCode(String word, Date currentAccountDate) {
        int code = this.service.loadCode(this.accountSetsId, word, currentAccountDate);
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
    public JsonResult carryForwardMoney(Integer years, Integer month, String[] code) {
        Map<String, VoucherDetails> detailsMap = this.service.carryForwardMoney(this.accountSetsId, years, month, code);
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
    public JsonResult finishingOffNo(Integer year, Integer month) {
        this.service.finishingOffNo(this.accountSetsId, year, month);
        return JsonResult.successful();
    }

    /**
     * 批量删除
     *
     * @param checked 凭证ID
     * @return
     */
    @PostMapping("batchDelete")
    public JsonResult batchDelete(Integer[] checked, Integer year, Integer month) {
        this.service.batchDelete(this.accountSetsId, checked, year, month);
        return JsonResult.successful();
    }

    /**
     * 批量审核
     *
     * @param checked 凭证ID
     * @return
     */
    @PostMapping("audit")
    public JsonResult audit(Integer[] checked, Integer year, Integer month) {
        this.service.audit(this.accountSetsId, checked, this.currentUser, year, month);
        return JsonResult.successful();
    }

    /**
     * 批量反审核
     *
     * @param checked 凭证ID
     * @return
     */
    @PostMapping("cancelAudit")
    public JsonResult cancelAudit(Integer[] checked, Integer year, Integer month) {
        this.service.cancelAudit(this.accountSetsId, checked, this.currentUser, year, month);
        return JsonResult.successful();
    }

    /**
     * 上一条
     *
     * @param currentId 凭证ID
     * @return
     */
    @GetMapping("beforeId")
    public JsonResult beforeId(Integer currentId) {
        Integer id = this.service.getBeforeId(this.accountSetsId, currentId);
        return JsonResult.successful(id);
    }

    /**
     * 下一条
     *
     * @param currentId 凭证ID
     * @return
     */
    @GetMapping("nextId")
    public JsonResult nextId(Integer currentId) {
        Integer id = this.service.getNextId(this.accountSetsId, currentId);
        return JsonResult.successful(id);
    }

    @Override
    public JsonResult save(@RequestBody Voucher entity) {
        JsonResult result = super.save(entity);
        if (result.isSuccess()) {
            DateFormat sdf = new SimpleDateFormat("yyyyMM");
            if (!sdf.format(this.currentUser.getAccountSets().getCurrentAccountDate()).equals(entity.getVoucherDate())) {
                this.session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));
            }
        }
        result.setData(entity);
        return result;
    }

    @GetMapping("summary")
    public JsonResult summary() {
        List<String> summary = this.service.getTopSummary(this.accountSetsId);
        summary = summary.stream().map(String::trim).collect(Collectors.toList());
        for (String s : defaultSummary) {
            if (!summary.contains(s)) {
                summary.add(s);
            }
        }
        return JsonResult.successful(summary);
    }

    @PostMapping("/import")
    public JsonResult importVoucher(@RequestParam("file") MultipartFile multipartFile) {
        try {
            List<Voucher> voucherList = excelUtils.readExcel(multipartFile.getOriginalFilename(), multipartFile.getInputStream(), this.currentUser);
            Date date = this.service.importVoucher(voucherList, this.currentUser.getAccountSets());
            this.session.setAttribute("user", this.userService.getUserVo(this.currentUser.getId()));
            return JsonResult.successful(date);
        } catch (ServiceException e) {
            return JsonResult.failure(e.getMessage());
        } catch (Exception e) {
            log.error("导入失败", e);
            throw new ServiceException("导入失败~", e);
        }
    }
}
