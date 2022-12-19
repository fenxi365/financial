package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.common.DateUtil;
import cn.gson.financial.kernel.common.DoubleComparer;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.Checkout;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.mapper.AccountSetsMapper;
import cn.gson.financial.kernel.model.mapper.CheckoutMapper;
import cn.gson.financial.kernel.model.mapper.VoucherDetailsMapper;
import cn.gson.financial.kernel.model.mapper.VoucherMapper;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.service.CheckoutService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月23日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
@Service
@AllArgsConstructor
public class CheckoutServiceImpl extends ServiceImpl<CheckoutMapper, Checkout> implements CheckoutService {

    private VoucherDetailsMapper voucherDetailsMapper;
    private VoucherMapper voucherMapper;
    private AccountSetsMapper accountSetsMapper;

    @Override
    public int batchInsert(List<Checkout> list) {
        return baseMapper.batchInsert(list);
    }

    /**
     * 期初检查
     *
     * @param accountSetsId
     * @return
     */
    @Override
    public boolean initialCheck(Integer accountSetsId) {
        Map<String, Double> maps = voucherDetailsMapper.selectListInitialCheckData(accountSetsId);
        if (maps == null) {
            return true;
        }
        Double jie = maps.getOrDefault("debit_amount", 0d);
        Double dai = maps.getOrDefault("credit_amount", 0d);
        return DoubleComparer.considerEqual(jie, dai);
    }

    /**
     * 期末检查
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    @Override
    public boolean finalCheck(Integer accountSetsId, Integer year, Integer month) {
        VoucherDetails details = voucherDetailsMapper.selectFinalCheckData(accountSetsId, year, month);
        if (details == null) {
            return true;
        }
        if (details.getDebitAmount() != null && details.getCreditAmount() != null) {
            return DoubleComparer.considerEqual(details.getDebitAmount(), details.getCreditAmount());
        } else return details.getDebitAmount() == null && details.getCreditAmount() == null;
    }

    /**
     * 报表检查
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    @Override
    public Map<String, Object> reportCheck(Integer accountSetsId, Integer year, Integer month) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);

        List<VoucherDetails> details = voucherDetailsMapper.assetStatistics(accountSetsId, DateUtil.getMonthEnd(cal.getTime()));
        Map<String, Object> result = new HashMap<>(4);
        result.put("result", true);
        if (details != null) {
            Optional<VoucherDetails> assets = details.stream().filter(vd -> vd.getSubjectName().equals("资产")).findFirst();
            Optional<VoucherDetails> liabilities = details.stream().filter(vd -> vd.getSubjectName().equals("负债")).findFirst();
            Optional<VoucherDetails> rightsAndInterests = details.stream().filter(vd -> vd.getSubjectName().equals("权益")).findFirst();

            double assetsNum = 0, liabilitiesNum = 0, rightsAndInterestsNum = 0;

            if (assets.isPresent()) {
                assetsNum = DoubleValueUtil.getNotNullVal(assets.get().getDebitAmount()) - DoubleValueUtil.getNotNullVal(assets.get().getCreditAmount());
            }

            if (liabilities.isPresent()) {
                liabilitiesNum = DoubleValueUtil.getNotNullVal(liabilities.get().getDebitAmount()) - DoubleValueUtil.getNotNullVal(liabilities.get().getCreditAmount());
            }

            if (rightsAndInterests.isPresent()) {
                rightsAndInterestsNum = DoubleValueUtil.getNotNullVal(rightsAndInterests.get().getDebitAmount()) - DoubleValueUtil.getNotNullVal(rightsAndInterests.get().getCreditAmount());
            }

            //资产类 - 负债类 = 权益类
            result.put("result", DoubleComparer.considerEqual(Math.abs(assetsNum - liabilitiesNum), Math.abs(rightsAndInterestsNum)));
            result.put("资产类", assetsNum);
            result.put("负债类", liabilitiesNum);
            result.put("权益类", rightsAndInterestsNum);
        }
        return result;
    }

    /**
     * 断号检查
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    @Override
    public boolean brokenCheck(Integer accountSetsId, Integer year, Integer month) {
        List<Map<String, Object>> data = this.voucherMapper.selectBrokenData(accountSetsId, year, month);
        return data.stream().allMatch(map -> map.get("total").equals(((Integer) map.get("code")).longValue()));
    }

    /**
     * 结账
     *
     * @param user
     * @param year
     * @param month
     * @return
     */
    @Override
    public boolean invoicing(UserVo user, Integer year, Integer month) {
        Calendar instance = Calendar.getInstance();
        instance.set(Calendar.YEAR, year);
        instance.set(Calendar.MONTH, month - 1);

        LambdaQueryWrapper<Checkout> qw = Wrappers.lambdaQuery();
        qw.eq(Checkout::getAccountSetsId, user.getAccountSetsId());
        qw.eq(Checkout::getCheckYear, year);
        qw.eq(Checkout::getCheckMonth, month);
        Checkout checkout = new Checkout();
        checkout.setStatus(2);
        checkout.setCheckDate(DateUtil.getMonthBegin(instance.getTime()));

        this.baseMapper.update(checkout, qw);

        DateFormat df = new SimpleDateFormat("yyyyMM");
        if (df.format(user.getAccountSets().getCurrentAccountDate()).equals(df.format(instance.getTime()))) {
            checkout = new Checkout();
            checkout.setAccountSetsId(user.getAccountSetsId());
            Date nextMonth = DateUtil.getMonthEnd(DateUtils.addMonths(user.getAccountSets().getCurrentAccountDate(), 1));
            instance = Calendar.getInstance();
            instance.setTime(nextMonth);
            checkout.setCheckYear(instance.get(Calendar.YEAR));
            checkout.setCheckMonth(instance.get(Calendar.MONTH) + 1);

            this.baseMapper.insert(checkout);
            //更新账套当前期间
            AccountSets accountSets = user.getAccountSets();
            accountSets.setCurrentAccountDate(nextMonth);
            this.accountSetsMapper.updateById(accountSets);
        }
        return true;
    }

    /**
     * 反结账
     *
     * @param currentUser
     * @param year
     * @param month
     * @return
     */
    @Override
    public boolean unCheck(UserVo currentUser, Integer year, Integer month) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 2);
        LambdaQueryWrapper<Checkout> cqw = Wrappers.lambdaQuery();
        cqw.eq(Checkout::getAccountSetsId, currentUser.getAccountSetsId());
        cqw.eq(Checkout::getStatus, 2);
        cqw.gt(Checkout::getCheckDate, DateUtil.getMonthEnd(cal.getTime()));
        Checkout checkout = new Checkout();
        checkout.setStatus(0);
        checkout.setCheckDate(null);
        baseMapper.update(checkout, cqw);
        return true;
    }

    @Override
    public List<Checkout> list(Wrapper<Checkout> queryWrapper) {
        QueryWrapper qw = (QueryWrapper) queryWrapper;
        qw.orderByDesc("check_year", "check_month");
        return super.list(qw);
    }
}

