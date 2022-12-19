package cn.gson.financial.controller;

import cn.gson.financial.base.BaseController;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
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
 * <li>Creation    : 2019年09月07日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/accountBook")
public class AccountBookController extends BaseController {

    @Autowired
    private SubjectService service;
    @Autowired
    private VoucherService voucherService;

    @ModelAttribute
    public void common(HttpServletRequest request) {
        this.currentUser = (UserVo) request.getSession().getAttribute("user");
        this.accountSetsId = this.currentUser.getAccountSetsId();
    }

    @RequestMapping("list")
    public JsonResult accountBookList(Date accountDate) {
        List<Subject> data = service.accountBookList(accountDate, this.accountSetsId, false);
        List<SubjectVo> collect = data.stream().map(subject -> {
            SubjectVo subjectVo = new SubjectVo();
            BeanUtils.copyProperties(subject, subjectVo);
            return subjectVo;
        }).collect(Collectors.toList());
        return JsonResult.successful(collect);
    }

    /**
     * 科目余额表
     *
     * @param accountDate
     * @return
     */
    @RequestMapping("subjectBalance")
    public JsonResult subjectBalance(Date accountDate, Boolean showNumPrice) {
        List data = service.subjectBalance(accountDate, this.accountSetsId, showNumPrice);
        return JsonResult.successful(data);
    }

    /**
     * 科目汇总
     *
     * @param accountDate
     * @return
     */
    @RequestMapping("subjectSummary")
    public JsonResult subjectSummary(Date accountDate, Boolean showNumPrice) {
        List data = service.subjectSummary(accountDate, this.accountSetsId, showNumPrice);
        return JsonResult.successful(data);
    }

    /**
     * 明细账
     *
     * @param subjectId
     * @param accountDate
     * @param subjectCode
     * @return
     */
    @GetMapping("details")
    public JsonResult accountBookDetails(Integer subjectId, Date accountDate, String subjectCode, Boolean showNumPrice) {
        List data = this.voucherService.accountBookDetails(this.accountSetsId, subjectId, accountDate, subjectCode, showNumPrice);
        return JsonResult.successful(data);
    }

    /**
     * 总账
     *
     * @param accountDate
     * @return
     */
    @GetMapping("generalLedger")
    public JsonResult generalLedger(Date accountDate, Boolean showNumPrice) {
        List<Map<String, Object>> data = this.voucherService.accountGeneralLedger(this.accountSetsId, accountDate, showNumPrice);
        return JsonResult.successful(data);
    }

    /**
     * 辅助明细账
     *
     * @param auxiliaryId
     * @param accountDate
     * @param auxiliaryItemId
     * @return
     */
    @GetMapping("auxiliaryDetails")
    public JsonResult auxiliaryDetails(Integer auxiliaryId, Date accountDate, Integer auxiliaryItemId, Boolean showNumPrice) {
        List data = this.voucherService.auxiliaryDetails(this.accountSetsId, auxiliaryId, accountDate, auxiliaryItemId, showNumPrice);
        return JsonResult.successful(data);
    }

    /**
     * 当期核算项目列表
     *
     * @param auxiliaryId
     * @return
     */
    @GetMapping("auxiliaryList")
    public JsonResult auxiliaryList(Integer auxiliaryId) {
        List data = this.voucherService.auxiliaryList(this.accountSetsId, auxiliaryId);
        return JsonResult.successful(data);
    }

    /**
     * 核算项目余额
     *
     * @param accountDate
     * @param auxiliaryId
     * @return
     */
    @GetMapping("auxiliaryBalance")
    public JsonResult auxiliaryBalance(Date accountDate, Integer auxiliaryId, Boolean showNumPrice) {
        List data = this.voucherService.auxiliaryBalance(this.accountSetsId, auxiliaryId, accountDate, showNumPrice);
        return JsonResult.successful(data);
    }

}

