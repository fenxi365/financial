package cn.gson.financial.controller;

import cn.gson.financial.base.BaseCrudController;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.vo.InitialBalanceVo;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherDetailsService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月05日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@RestController
@RequestMapping("/initial-balance")
@AllArgsConstructor
@Slf4j
public class InitialBalanceController extends BaseCrudController<VoucherDetailsService, VoucherDetails> {

    private SubjectService subjectService;

    @Override
    public JsonResult list(@RequestParam Map<String, String> params) {
        List<VoucherDetails> balanceList = this.service.balanceList(this.accountSetsId, params.get("type"));
        List<VoucherDetails> auxiliaryList = this.service.auxiliaryList(this.accountSetsId, params.get("type"));
        Map<String, VoucherDetails> detailsMap = balanceList.stream().collect(Collectors.toMap(v -> v.getSubjectId() + v.getSubjectCode(), voucherDetails -> voucherDetails));
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.orderByAsc(Subject::getCode);
        qw.eq(Subject::getAccountSetsId, this.accountSetsId);
        qw.eq(Subject::getType, params.get("type"));
        List<Integer> leafs = subjectService.leafList(this.accountSetsId);
        ArrayList<InitialBalanceVo> result = subjectService.list(qw).stream().collect(ArrayList::new, (list, subject) -> {
            VoucherDetails details = detailsMap.get(subject.getId() + subject.getCode());
            InitialBalanceVo vo = new InitialBalanceVo();

            setData(vo, details);

            vo.setSubjectId(subject.getId());
            vo.setType(subject.getType());
            vo.setCode(subject.getCode());
            vo.setName(subject.getName());
            vo.setMnemonicCode(subject.getMnemonicCode());
            vo.setBalanceDirection(subject.getBalanceDirection());
            vo.setStatus(subject.getStatus());
            vo.setParentId(subject.getParentId());
            vo.setLevel(subject.getLevel());
            vo.setSystemDefault(subject.getSystemDefault());
            vo.setAccountSetsId(subject.getAccountSetsId());
            vo.setUnit(subject.getUnit());
            vo.setAuxiliaryAccounting(subject.getAuxiliaryAccounting());
            vo.setLeaf(leafs.contains(subject.getId()));

            list.add(vo);
        }, List::addAll);

        auxiliaryList.forEach(voucherDetails -> {
            InitialBalanceVo vo = new InitialBalanceVo();
            Subject subject = voucherDetails.getSubject();
            VoucherDetails details = detailsMap.get(subject.getId() + voucherDetails.getSubjectCode());

            setData(vo, details);

            vo.setSubjectId(voucherDetails.getSubjectId());
            vo.setCode(voucherDetails.getSubjectCode());
            vo.setName(subject.getName() + voucherDetails.getAuxiliaryTitle());
            vo.setBalanceDirection(subject.getBalanceDirection());
            vo.setParentId(subject.getParentId());
            vo.setLevel((short) (subject.getLevel() + 1));
            vo.setSystemDefault(subject.getSystemDefault());
            vo.setAccountSetsId(subject.getAccountSetsId());
            vo.setUnit(subject.getUnit());
            vo.setLeaf(true);

            result.add(vo);
        });

        return JsonResult.successful(result.stream().sorted(Comparator.comparing(Subject::getCode)).collect(Collectors.toList()));
    }

    private void setData(InitialBalanceVo vo, VoucherDetails details) {
        if (details != null) {
            vo.setBeginBalance(DoubleValueUtil.getNotNullVal(details.getDebitAmount(), details.getCreditAmount()));
            vo.setNum(details.getNum());
            vo.setCumulativeCredit(details.getCumulativeCredit());
            vo.setCumulativeDebit(details.getCumulativeDebit());
            vo.setCumulativeCreditNum(details.getCumulativeCreditNum());
            vo.setCumulativeDebitNum(details.getCumulativeDebitNum());
        }
    }

    @Override
    public JsonResult save(@RequestBody VoucherDetails entity) {
        JsonResult result = super.save(entity);
        result.setData(entity);
        return result;
    }

    @PostMapping("auxiliary")
    public JsonResult auxiliary(@RequestBody HashMap<String, Object> entity) {
        this.service.saveAuxiliary(this.accountSetsId, entity);
        return JsonResult.successful();
    }

    @GetMapping("trialBalance")
    public JsonResult trialBalance() {
        Map<String, Map<String, Double>> data = this.service.trialBalance(this.accountSetsId);
        return JsonResult.successful(data);
    }
}
