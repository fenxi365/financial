package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.entity.VoucherDetailsAuxiliary;
import cn.gson.financial.kernel.model.mapper.AccountingCategoryDetailsMapper;
import cn.gson.financial.kernel.model.mapper.SubjectMapper;
import cn.gson.financial.kernel.model.mapper.VoucherDetailsAuxiliaryMapper;
import cn.gson.financial.kernel.model.mapper.VoucherDetailsMapper;
import cn.gson.financial.kernel.service.VoucherDetailsService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
public class VoucherDetailsServiceImpl extends ServiceImpl<VoucherDetailsMapper, VoucherDetails> implements VoucherDetailsService {

    @Autowired
    private SubjectMapper subjectMapper;

    @Autowired
    private AccountingCategoryDetailsMapper categoryDetailsMapper;

    @Autowired
    private VoucherDetailsAuxiliaryMapper detailsAuxiliaryMapper;

    @Override
    public int batchInsert(List<VoucherDetails> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public boolean save(VoucherDetails entity) {
        LambdaQueryWrapper<VoucherDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherDetails::getAccountSetsId, entity.getAccountSetsId());
        qw.eq(VoucherDetails::getSubjectId, entity.getSubjectId());
        qw.eq(VoucherDetails::getSubjectCode, entity.getSubjectCode());
        qw.isNull(VoucherDetails::getVoucherId);

        if (this.baseMapper.selectCount(qw) > 0) {
            return super.update(entity, qw);
        }
        return super.save(entity);
    }

    /**
     * 期初数据
     *
     * @param accountSetsId
     * @param type
     * @return
     */
    @Override
    public List<VoucherDetails> balanceList(Integer accountSetsId, String type) {
        return this.baseMapper.selectBalanceList(accountSetsId, type);
    }

    /**
     * 期初试算平衡
     *
     * @param accountSetsId
     * @return
     */
    @Override
    public Map<String, Map<String, Double>> trialBalance(Integer accountSetsId) {
        Map<String, Double> beginningBalance = this.baseMapper.selectListInitialCheckData(accountSetsId);
        List<Map> liabilities = this.baseMapper.selectBassetsAndLiabilities(accountSetsId);
        Map<String, Double> bb = new HashMap<>();
        Map<String, Double> bl = new HashMap<>();
        bb.put("借", beginningBalance != null ? beginningBalance.get("debit_amount") : 0d);
        bb.put("贷", beginningBalance != null ? beginningBalance.get("credit_amount") : 0d);

        Map<String, List<Map>> collect = liabilities.stream().collect(Collectors.groupingBy(map -> (String) map.get("type")));
        collect.forEach((type, maps) -> {
            Optional<Map> borrow = maps.stream().filter(map -> "借".equals(map.get("balance_direction"))).findFirst();
            Optional<Map> credit = maps.stream().filter(map -> "贷".equals(map.get("balance_direction"))).findFirst();

            if (borrow.isPresent() && credit.isPresent()) {
                Double balanceBorrow = DoubleValueUtil.getNotNullVal((Double) borrow.get().get("debit_amount"), (Double) borrow.get().get("credit_amount"));
                Double balanceCredit = DoubleValueUtil.getNotNullVal((Double) credit.get().get("debit_amount"), (Double) credit.get().get("credit_amount"));
                bl.put(type, balanceBorrow - balanceCredit);
            } else if (borrow.isPresent()) {
                Double balanceBorrow = DoubleValueUtil.getNotNullVal((Double) borrow.get().get("debit_amount"), (Double) borrow.get().get("credit_amount"));
                bl.put(type, balanceBorrow);
            } else if (credit.isPresent()) {
                Double balanceCredit = DoubleValueUtil.getNotNullVal((Double) credit.get().get("debit_amount"), (Double) credit.get().get("credit_amount"));
                bl.put(type, balanceCredit);
            }
        });

        Map<String, Map<String, Double>> data = new HashMap<>();

        data.put("beginningBalance", bb);
        data.put("liabilities", bl);

        return data;
    }

    @Override
    public void saveAuxiliary(Integer accountSetsId, HashMap<String, Object> entity) {
        Integer subjectId = (Integer) entity.get("subjectId");
        JSONObject auxiliary = (JSONObject) entity.get("auxiliary");
        Subject subject = subjectMapper.selectById(subjectId);
        List<AccountingCategoryDetails> categoryDetails = categoryDetailsMapper.selectBatchIds(auxiliary.values().stream().mapToInt(o -> (Integer) o).boxed().collect(Collectors.toList()));

        StringBuilder auxiliaryTitle = new StringBuilder();
        StringBuilder subjectCode = new StringBuilder(subject.getCode());

        for (AccountingCategoryDetails cd : categoryDetails) {
            auxiliaryTitle.append("_").append(cd.getName());
            subjectCode.append("_").append(cd.getId());
        }

        LambdaQueryWrapper<VoucherDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherDetails::getAccountSetsId, accountSetsId);
        qw.eq(VoucherDetails::getSubjectId, subjectId);
        qw.eq(VoucherDetails::getSubjectCode, subjectCode.toString());
        qw.isNull(VoucherDetails::getVoucherId);

        VoucherDetails details = this.baseMapper.selectOne(qw);
        if (details == null) {
            details = new VoucherDetails();
            details.setSummary("期初");
            details.setSubjectId(subjectId);
            details.setSubjectName(subjectCode.toString() + "-" + subject.getName());
            details.setSubjectCode(subjectCode.toString());
            details.setAuxiliaryTitle(auxiliaryTitle.toString());
            details.setAccountSetsId(accountSetsId);
            this.baseMapper.insert(details);
        }

        List<VoucherDetailsAuxiliary> voucherDetailsAuxiliaries = new ArrayList<>();

        for (AccountingCategoryDetails cd : categoryDetails) {
            LambdaQueryWrapper<VoucherDetailsAuxiliary> aqw = Wrappers.lambdaQuery();
            aqw.eq(VoucherDetailsAuxiliary::getVoucherDetailsId, details.getId());
            aqw.eq(VoucherDetailsAuxiliary::getAccountingCategoryId, cd.getAccountingCategoryId());
            aqw.eq(VoucherDetailsAuxiliary::getAccountingCategoryDetailsId, cd.getId());

            if (detailsAuxiliaryMapper.selectCount(aqw) == 0) {
                VoucherDetailsAuxiliary vda = new VoucherDetailsAuxiliary();
                vda.setVoucherDetailsId(details.getId());
                vda.setAccountingCategoryId(cd.getAccountingCategoryId());
                vda.setAccountingCategoryDetailsId(cd.getId());
                voucherDetailsAuxiliaries.add(vda);
            }
        }

        if (!voucherDetailsAuxiliaries.isEmpty()) {
            detailsAuxiliaryMapper.batchInsert(voucherDetailsAuxiliaries);
        }
    }

    @Override
    public List<VoucherDetails> auxiliaryList(Integer accountSetsId, String type) {
        return this.baseMapper.selectAuxiliaryList(accountSetsId, type);
    }

    /**
     * 科目会计期间的累计金额
     *
     * @param accountSetsId
     * @param codeList
     * @param currentAccountDate
     * @return
     */
    @Override
    public Map<String, VoucherDetails> getAggregateAmount(Integer accountSetsId, Set<String> codeList, Date currentAccountDate) {
        Calendar instance = Calendar.getInstance();
        instance.setTime(currentAccountDate);
        List<VoucherDetails> details = this.baseMapper.selectAggregateAmount(accountSetsId, codeList, instance.get(Calendar.YEAR), instance.get(Calendar.MONTH) + 1);
        return details.stream().collect(Collectors.toMap(VoucherDetails::getSubjectCode, voucherDetails -> voucherDetails));
    }
}











