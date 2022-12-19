package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.common.DateUtil;
import cn.gson.financial.kernel.common.DoubleComparer;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.*;
import cn.gson.financial.kernel.model.mapper.*;
import cn.gson.financial.kernel.model.vo.BalanceVo;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
@Slf4j
@Service
@AllArgsConstructor
public class VoucherServiceImpl extends ServiceImpl<VoucherMapper, Voucher> implements VoucherService {

    private VoucherDetailsMapper detailsMapper;

    private SubjectMapper subjectMapper;

    private VoucherDetailsAuxiliaryMapper voucherDetailsAuxiliaryMapper;

    private SubjectService subjectService;

    private CheckoutMapper checkoutMapper;

    private AccountSetsMapper accountSetsMapper;

    @Override
    public int batchInsert(List<Voucher> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public List<Voucher> list(Wrapper<Voucher> queryWrapper) {
        return baseMapper.selectVoucher(queryWrapper);
    }

    @Override
    public IPage<Voucher> page(IPage<Voucher> page, Wrapper<Voucher> queryWrapper) {
        return baseMapper.selectVoucher(page, queryWrapper);
    }

    @Override
    public int loadCode(Integer accountSetsId, String word, Date currentAccountDate) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(currentAccountDate);
        Integer code = baseMapper.selectMaxCode(accountSetsId, word, calendar.get(Calendar.YEAR), calendar.get(Calendar.MONDAY) + 1);
        return code == null ? 1 : code;
    }

    @Override
    public List accountBookDetails(Integer accountSetsId, Integer subjectId, Date accountDate, String subjectCode, Boolean showNumPrice) {
        return this.summary(accountSetsId, subjectId, accountDate, subjectCode, showNumPrice, true);
    }

    @Override
    public List accountGeneralLedger(Integer accountSetsId, Date accountDate, Boolean showNumPrice) {
        List<Subject> subjectList = subjectService.accountBookList(accountDate, accountSetsId, showNumPrice);
        List<Map<String, Object>> data = new ArrayList<>(subjectList.size());
        subjectList.forEach(subject -> {
            List<VoucherDetailVo> summary = this.summary(accountSetsId, subject.getId(), accountDate, subject.getCode(), showNumPrice, false);
            Map<String, Object> item = new HashMap<>(2);
            item.put("subject", subject);
            item.put("summary", summary);
            data.add(item);
        });
        return data;
    }

    /**
     * 获取期间结转科目总和
     *
     * @param accountSetsId
     * @param years
     * @param month
     * @param code
     * @return
     */
    @Override
    public Map<String, VoucherDetails> carryForwardMoney(Integer accountSetsId, Integer years, Integer month, String[] code) {
        Map<String, VoucherDetails> msv = new HashMap<>(code.length);
        for (String s : code) {
            VoucherDetails details = this.detailsMapper.selectCarryForwardMoney(accountSetsId, years, month, s + "%");
            msv.put(s, details);
        }
        return msv;
    }

    /**
     * 核算项目明细账
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @param accountDate
     * @param auxiliaryItemId
     * @param showNumPrice
     * @return
     */
    @Override
    public List<VoucherDetailVo> auxiliaryDetails(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Integer auxiliaryItemId, Boolean showNumPrice) {
        List<VoucherDetailVo> data = new ArrayList<>();
        //期初
        VoucherDetailVo startVo = getAuxiliaryStart(accountSetsId, auxiliaryId, accountDate, auxiliaryItemId);
        data.add(startVo);

        //明细
        List<VoucherDetailVo> detailVos = voucherDetailsAuxiliaryMapper.selectAccountBookDetails(accountSetsId, auxiliaryId, accountDate, auxiliaryItemId);
        //计算每次余额
        for (VoucherDetailVo vo : detailVos) {
            double b = 0d;
            switch (vo.getBalanceDirection()) {
                case "借":
                    b = DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
                    break;
                case "贷":
                    b = DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount());
                    break;
            }
            vo.setBalance(startVo.getBalance() + b);
            startVo = vo;
        }

        data.addAll(detailVos);
        //本期统计
        VoucherDetailVo currentVo = getAuxiliaryCurrent(accountSetsId, auxiliaryId, accountDate, auxiliaryItemId, data.get(0));
        //年度统计
        VoucherDetailVo yearVo = getAuxiliaryYear(accountSetsId, auxiliaryId, accountDate, auxiliaryItemId);
        data.add(currentVo);
        data.add(yearVo);
        return data;
    }

    /**
     * 获取期初统计
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @param accountDate
     * @param auxiliaryItemId
     * @return
     */
    private VoucherDetailVo getAuxiliaryStart(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Integer auxiliaryItemId) {
        List<VoucherDetailVo> startVos = voucherDetailsAuxiliaryMapper.selectAccountBookStatistical(accountSetsId, auxiliaryId, null, DateUtil.getMonthBegin(accountDate), auxiliaryItemId);
        VoucherDetailVo startVo = new VoucherDetailVo();
        startVo.setSummary("期初余额");
        startVo.setVoucherDate(accountDate);
        startVo.setBalance(0d);
        startVo.setBalanceDirection("平");

        if (startVos != null && !startVos.isEmpty()) {
            if (startVos.get(0) != null) {
                VoucherDetailVo vo = startVos.get(0);
                startVo.setBalanceDirection(vo.getBalanceDirection());
                switch (vo.getBalanceDirection()) {
                    case "借":
                        startVo.setBalance(DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount()));
                        break;
                    case "贷":
                        startVo.setBalance(DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount()));
                        break;
                }
                startVo.setCreditAmount(vo.getCreditAmount());
                startVo.setDebitAmount(vo.getDebitAmount());
            }
        }
        return startVo;
    }

    /**
     * 获取本期统计
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @param accountDate
     * @param auxiliaryItemId
     * @return
     */
    private VoucherDetailVo getAuxiliaryCurrent(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Integer auxiliaryItemId, VoucherDetailVo startVo) {
        List<VoucherDetailVo> vos = voucherDetailsAuxiliaryMapper.selectAccountBookStatistical(accountSetsId, auxiliaryId, DateUtil.getMonthBegin(accountDate), DateUtil.getMonthEnd(accountDate), auxiliaryItemId);
        VoucherDetailVo currentVo = new VoucherDetailVo();
        currentVo.setSummary("本期合计");
        currentVo.setVoucherDate(accountDate);
        currentVo.setBalance(0d);
        currentVo.setBalanceDirection("平");

        if (vos != null && !vos.isEmpty() && vos.get(0) != null) {
            VoucherDetailVo vo = vos.get(0);
            //加上期初余额
            switch (vo.getBalanceDirection()) {
                case "借":
                    currentVo.setBalance(DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) + startVo.getBalance());
                    break;
                case "贷":
                    currentVo.setBalance(DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) + startVo.getBalance());
                    break;
            }
            currentVo.setCreditAmount(vo.getCreditAmount());
            currentVo.setDebitAmount(vo.getDebitAmount());
            if (!DoubleComparer.considerEqual(currentVo.getBalance(), 0d)) {
                currentVo.setBalanceDirection(vo.getBalanceDirection());
            }
        }
        return currentVo;
    }

    /**
     * 获取年度统计
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @param accountDate
     * @param auxiliaryItemId
     * @return
     */
    private VoucherDetailVo getAuxiliaryYear(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Integer auxiliaryItemId) {
        List<VoucherDetailVo> startVos = voucherDetailsAuxiliaryMapper.selectAccountBookStatistical(accountSetsId, auxiliaryId, null, DateUtil.getYearBegin(accountDate), auxiliaryItemId);
        VoucherDetailVo startVo = new VoucherDetailVo();
        startVo.setBalance(0d);
        if (startVos != null && !startVos.isEmpty() && startVos.get(0) != null) {
            startVo = startVos.get(0);
            double b = 0d;
            switch (startVo.getBalanceDirection()) {
                case "借":
                    b = DoubleValueUtil.getNotNullVal(startVo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(startVo.getCreditAmount());
                    break;
                case "贷":
                    b = DoubleValueUtil.getNotNullVal(startVo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(startVo.getDebitAmount());
                    break;
            }
            startVo.setBalance(b);
        }
        List<VoucherDetailVo> vos = voucherDetailsAuxiliaryMapper.selectAccountBookStatistical(accountSetsId, auxiliaryId, DateUtil.getYearBegin(accountDate), DateUtil.getMonthEnd(accountDate), auxiliaryItemId);
        VoucherDetailVo yearVo = new VoucherDetailVo();
        yearVo.setSummary("本年累计");
        yearVo.setVoucherDate(accountDate);
        yearVo.setBalance(0d);
        yearVo.setBalanceDirection("平");

        if (vos != null && !vos.isEmpty() && vos.get(0) != null) {
            VoucherDetailVo vo = vos.get(0);
            //加上期初余额
            double b = 0d;
            switch (vo.getBalanceDirection()) {
                case "借":
                    b = DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
                    break;
                case "贷":
                    b = DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount());
                    break;
            }
            yearVo.setBalance(b + startVo.getBalance());
            yearVo.setCreditAmount(vo.getCreditAmount());
            yearVo.setDebitAmount(vo.getDebitAmount());

            if (!DoubleComparer.considerEqual(yearVo.getBalance(), 0d)) {
                yearVo.setBalanceDirection(vo.getBalanceDirection());
            }
        }
        return yearVo;
    }

    /**
     * 本期核算项目
     *
     * @param accountSetsId
     * @return
     */
    @Override
    public List<AccountingCategoryDetails> auxiliaryList(Integer accountSetsId, Integer auxiliaryId) {
        return voucherDetailsAuxiliaryMapper.selectByAccountBlock(accountSetsId, auxiliaryId);
    }

    /**
     * 辅助核算项目余额
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @param accountDate
     * @param showNumPrice
     * @return
     */
    @Override
    public List<BalanceVo> auxiliaryBalance(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Boolean showNumPrice) {
        //所有辅助项目
        List<AccountingCategoryDetails> categoryDetails = voucherDetailsAuxiliaryMapper.selectByAccountBlock(accountSetsId, auxiliaryId);
        //转换成待计算的辅助项目
        Map<Integer, BalanceVo> maps = new HashMap<>(categoryDetails.size());
        categoryDetails.forEach(details -> {
            BalanceVo vo = new BalanceVo();
            vo.setName(details.getName());
            vo.setCode(details.getCode());
            vo.setAuxiliaryId(details.getId());
            maps.put(details.getId(), vo);
        });

        //期初
        List<VoucherDetailVo> startVos = voucherDetailsAuxiliaryMapper.selectAccountBookStatistical(accountSetsId, auxiliaryId, null, DateUtil.getMonthBegin(accountDate), null);
        startVos.forEach(startVo -> {
            if (maps.containsKey(startVo.getDetailsId())) {
                BalanceVo vo = maps.get(startVo.getDetailsId());
                vo.setBalanceDirection(startVo.getBalanceDirection());
                vo.setBeginningBalance(DoubleValueUtil.getNotNullVal(startVo.getDebitAmount(), startVo.getCreditAmount()));
            }
        });

        //本期
        List<VoucherDetailVo> currentVos = voucherDetailsAuxiliaryMapper.selectAccountBookStatistical(accountSetsId, auxiliaryId, DateUtil.getMonthBegin(accountDate), DateUtil.getMonthEnd(accountDate), null);
        currentVos.forEach(currentVo -> {
            if (maps.containsKey(currentVo.getDetailsId())) {
                BalanceVo vo = maps.get(currentVo.getDetailsId());
                vo.setBalanceDirection(currentVo.getBalanceDirection());
                vo.setCurrentDebitAmount(currentVo.getDebitAmount());
                vo.setCurrentCreditAmount(currentVo.getCreditAmount());
            }
        });

        //计算期末余额
        BalanceVo aCombined = new BalanceVo();
        aCombined.setName("合计");

        for (BalanceVo balanceVo : maps.values()) {
            double endingData;
            if (balanceVo.getBalanceDirection() == null) {
                continue;
            }
            switch (balanceVo.getBalanceDirection()) {
                case "借":
                    endingData = DoubleValueUtil.getNotNullVal(balanceVo.getBeginningDebitBalance()) - DoubleValueUtil.getNotNullVal(balanceVo.getBeginningCreditBalance())
                            + DoubleValueUtil.getNotNullVal(balanceVo.getCurrentDebitAmount()) - DoubleValueUtil.getNotNullVal(balanceVo.getCurrentCreditAmount());
                    break;
                default:
                    endingData = DoubleValueUtil.getNotNullVal(balanceVo.getBeginningCreditBalance()) - DoubleValueUtil.getNotNullVal(balanceVo.getBeginningDebitBalance())
                            + DoubleValueUtil.getNotNullVal(balanceVo.getCurrentCreditAmount()) - DoubleValueUtil.getNotNullVal(balanceVo.getCurrentDebitAmount());
                    break;
            }

            balanceVo.setEndingActiveBalance(endingData);

            aCombined.setBeginningCreditBalance(balanceVo.getBeginningCreditBalance());
            aCombined.setBeginningDebitBalance(balanceVo.getBeginningDebitBalance());
            aCombined.setCurrentCreditAmount(balanceVo.getCurrentCreditAmount());
            aCombined.setCurrentDebitAmount(balanceVo.getCurrentDebitAmount());
            aCombined.setEndingDebitBalance(balanceVo.getEndingDebitBalance());
            aCombined.setEndingCreditBalance(balanceVo.getEndingCreditBalance());
        }

        List<BalanceVo> collect = maps.values().stream().sorted(Comparator.comparing(BalanceVo::getCode)).collect(Collectors.toList());

        if (collect.size() > 0) {
            collect = collect.stream().filter(vo ->
                    (vo.getBeginningBalance() != null && vo.getBeginningBalance() != 0) ||
                            (vo.getEndingBalance() != null && vo.getEndingBalance() != 0) ||
                            (vo.getCurrentDebitAmount() != null && vo.getCurrentDebitAmount() != 0) ||
                            (vo.getCurrentCreditAmount() != null && vo.getCurrentCreditAmount() != 0)
            ).collect(Collectors.toList());
            collect.add(aCombined);
        }

        return collect;
    }

    /**
     * 首页收入利润图表数据
     *
     * @param accountSetsId
     * @param year
     * @return
     */
    @Override
    public List<Map<String, Object>> getHomeReport(Integer accountSetsId, Integer year) {
        return baseMapper.selectHomeReport(accountSetsId, year);
    }

    /**
     * 首页费用数据
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    @Override
    public List<Map<String, Object>> getCostReport(Integer accountSetsId, int year, int month) {
        return baseMapper.selectHomeCostReport(accountSetsId, year, month);
    }

    /**
     * 首页现金数据
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    @Override
    public List<Map<String, Object>> getCashReport(Integer accountSetsId, int year, int month) {
        return baseMapper.selectHomeCashReport(accountSetsId, year, month);
    }

    /**
     * 断号整理
     *
     * @param accountSetsId
     * @param year
     * @param month
     */
    @Override
    @Transactional
    public void finishingOffNo(Integer accountSetsId, Integer year, Integer month) {
        this.checkCheckOut(accountSetsId, year, month);

        List<Map<String, Object>> data = this.baseMapper.selectBrokenData(accountSetsId, year, month);
        //过滤出没有连续的凭证字类别
        List<Map<String, Object>> collect = data.stream().filter(map -> !map.get("total").equals(((Integer) map.get("code")).longValue())).collect(Collectors.toList());
        if (!collect.isEmpty()) {
            List<Voucher> updateVouchers = new ArrayList<>();
            collect.forEach(it -> {
                String word = (String) it.get("word");
                LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
                qw.eq(Voucher::getWord, word);
                qw.eq(Voucher::getAccountSetsId, accountSetsId);
                qw.eq(Voucher::getVoucherYear, year);
                qw.eq(Voucher::getVoucherMonth, month);
                qw.orderByAsc(Voucher::getCreateDate);
                List<Voucher> vouchers = this.baseMapper.selectList(qw);

                //重置 code
                int code = 1;
                for (Voucher voucher : vouchers) {
                    voucher.setCode(code);
                    code++;
                }
                updateVouchers.addAll(vouchers);
            });

            this.updateBatchById(updateVouchers);
        }
    }

    /**
     * 批量删除
     *
     * @param accountSetsId
     * @param checked
     */
    @Override
    public void batchDelete(Integer accountSetsId, Integer[] checked, Integer year, Integer month) {
        this.checkCheckOut(accountSetsId, year, month);

        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getAccountSetsId, accountSetsId);
        qw.eq(Voucher::getVoucherYear, year);
        qw.eq(Voucher::getVoucherMonth, month);
        qw.in(Voucher::getId, Arrays.asList(checked));

        this.baseMapper.delete(qw);
    }

    /**
     * 根据当前 Id 获取上一条 ID
     *
     * @param accountSetsId
     * @param currentId
     * @return
     */
    @Override
    public Integer getBeforeId(Integer accountSetsId, Integer currentId) {
        return this.baseMapper.selectBeforeId(accountSetsId, currentId);
    }

    /**
     * 根据当前 Id 获取下一条 ID
     *
     * @param accountSetsId
     * @param currentId
     * @return
     */
    @Override
    public Integer getNextId(Integer accountSetsId, Integer currentId) {
        return this.baseMapper.selectNextId(accountSetsId, currentId);
    }

    /**
     * 获取最近使用的摘要
     *
     * @param accountSetsId
     * @return
     */
    @Override
    public List<String> getTopSummary(Integer accountSetsId) {
        return this.detailsMapper.selectTopSummary(accountSetsId);
    }

    /**
     * 审核
     *
     * @param accountSetsId
     * @param checked
     * @param year
     * @param month
     */
    @Override
    public void audit(Integer accountSetsId, Integer[] checked, UserVo currentUser, Integer year, Integer month) {
        this.checkCheckOut(accountSetsId, year, month);
        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getAccountSetsId, accountSetsId);
        qw.eq(Voucher::getVoucherYear, year);
        qw.eq(Voucher::getVoucherMonth, month);
        qw.in(Voucher::getId, Arrays.asList(checked));
        qw.isNull(Voucher::getAuditMemberId);
        List<Voucher> vouchers = baseMapper.selectList(qw);
        if (!vouchers.isEmpty()) {
            vouchers.forEach(voucher -> {
                voucher.setAuditMemberId(currentUser.getId());
                voucher.setAuditMemberName(currentUser.getRealName());
                voucher.setAuditDate(new Date());
            });
            this.updateBatchById(vouchers);
        }
    }

    /**
     * 反审核
     *
     * @param accountSetsId
     * @param checked
     * @param year
     * @param month
     */
    @Override
    public void cancelAudit(Integer accountSetsId, Integer[] checked, UserVo currentUser, Integer year, Integer month) {
        this.checkCheckOut(accountSetsId, year, month);
        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getAccountSetsId, accountSetsId);
        qw.eq(Voucher::getVoucherYear, year);
        qw.eq(Voucher::getVoucherMonth, month);
        qw.in(Voucher::getId, Arrays.asList(checked));
        qw.isNotNull(Voucher::getAuditMemberId);
        baseMapper.updateAudit(qw);

    }

    /**
     * 批量导入凭证
     *
     * @param voucherList
     * @return
     */
    @Override
    @Transactional
    public Date importVoucher(List<Voucher> voucherList, AccountSets accountSets) {
        List<Date> voucherDateList = new ArrayList<>();
        for (Voucher voucher : voucherList) {
            this.save(voucher, accountSets, true);
            voucherDateList.add(DateUtil.getMonthEnd(voucher.getVoucherDate()));
        }

        List<Date> collect = voucherDateList.stream().distinct().sorted().collect(Collectors.toList());
        collect.forEach(date -> {
            LambdaQueryWrapper<Checkout> cqw = Wrappers.lambdaQuery();
            Calendar instance = Calendar.getInstance();
            instance.setTime(date);
            cqw.eq(Checkout::getAccountSetsId, accountSets.getId());
            cqw.eq(Checkout::getCheckYear, instance.get(Calendar.YEAR));
            cqw.eq(Checkout::getCheckMonth, instance.get(Calendar.MONTH) + 1);
            if (this.checkoutMapper.selectCount(cqw) == 0) {
                Checkout checkout = new Checkout();
                checkout.setAccountSetsId(accountSets.getId());
                checkout.setCheckYear(instance.get(Calendar.YEAR));
                checkout.setCheckMonth(instance.get(Calendar.MONTH) + 1);
                this.checkoutMapper.insert(checkout);
            }
        });

        Date date = this.baseMapper.selectMaxVoucherDate(accountSets.getId());
        accountSets.setCurrentAccountDate(DateUtil.getMonthEndWithTime(date, false));
        this.accountSetsMapper.updateById(accountSets);
        return date;
    }

    private boolean save(Voucher entity, AccountSets accountSets, boolean imports) {
        this.setYearAndMonth(entity);
        this.checkCode(entity);
        boolean rs = super.save(entity);

        double debitAmount = 0d;
        double creditAmount = 0d;
        if (rs) {
            for (VoucherDetails vd : entity.getDetails()) {
                vd.setVoucherId(entity.getId());
                vd.setAccountSetsId(entity.getAccountSetsId());
                vd.setCarryForward(entity.getCarryForward());
                if (vd.getDebitAmount() != null) {
                    debitAmount += vd.getDebitAmount();
                }
                if (vd.getCreditAmount() != null) {
                    creditAmount += vd.getCreditAmount();
                }
            }

            detailsMapper.batchInsert(entity.getDetails());

            //存储辅助项目
            for (VoucherDetails voucherDetails : entity.getDetails()) {
                voucherDetails.setSummary(StringUtils.trim(voucherDetails.getSummary()));
                voucherDetails.setSubjectCode(StringUtils.trim(voucherDetails.getSubjectCode()));
                int size;
                if ((size = voucherDetails.getAuxiliary().size()) > 0) {
                    List<VoucherDetailsAuxiliary> vdas = new ArrayList<>(size);
                    voucherDetails.getAuxiliary().forEach(acd -> {
                        VoucherDetailsAuxiliary vda = new VoucherDetailsAuxiliary();
                        vda.setVoucherDetailsId(voucherDetails.getId());
                        vda.setAccountingCategoryId(acd.getAccountingCategoryId());
                        vda.setAccountingCategoryDetailsId(acd.getId());
                        vdas.add(vda);
                    });

                    voucherDetailsAuxiliaryMapper.batchInsert(vdas);
                }
            }

            //更新总和
            entity.setCreditAmount(creditAmount);
            entity.setDebitAmount(debitAmount);
            baseMapper.updateById(entity);

            if (!imports) {
                // 如果是非当前期间切，当前账套时间在凭证时间之前，需要更改默认期间
                DateFormat df = new SimpleDateFormat("yyyyMM");
                if (!df.format(accountSets.getCurrentAccountDate()).equals(df.format(entity.getVoucherDate())) &&
                        accountSets.getCurrentAccountDate().before(entity.getVoucherDate())
                ) {
                    LambdaQueryWrapper<Checkout> cqw = Wrappers.lambdaQuery();
                    cqw.eq(Checkout::getAccountSetsId, entity.getAccountSetsId());
                    cqw.eq(Checkout::getCheckYear, entity.getVoucherYear());
                    cqw.eq(Checkout::getCheckMonth, entity.getVoucherMonth());
                    if (this.checkoutMapper.selectCount(cqw) == 0) {
                        Checkout checkout = new Checkout();
                        checkout.setAccountSetsId(entity.getAccountSetsId());
                        checkout.setCheckYear(entity.getVoucherYear());
                        checkout.setCheckMonth(entity.getVoucherMonth());
                        checkout.setCheckDate(entity.getVoucherDate());
                        this.checkoutMapper.insert(checkout);

                        //更新当前账套的当前期间
                        accountSets.setCurrentAccountDate(checkout.getCheckDate());
                        this.accountSetsMapper.updateById(accountSets);
                    }
                }
            }

        }

        return rs;
    }

    @Override
    @Transactional
    public boolean save(Voucher entity) {
        return this.save(entity, this.accountSetsMapper.selectById(entity.getAccountSetsId()), false);
    }

    @Override
    @Transactional
    public boolean update(Voucher entity, Wrapper<Voucher> updateWrapper) {
        this.setYearAndMonth(entity);
        this.checkCheckOut(entity.getAccountSetsId(), entity.getVoucherYear(), entity.getVoucherMonth());
        this.checkCode(entity);

        boolean rs = super.update(entity, updateWrapper);

        //删除原有明细
        LambdaQueryWrapper<VoucherDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherDetails::getVoucherId, entity.getId());
        detailsMapper.delete(qw);

        double debitAmount = 0d;
        double creditAmount = 0d;
        if (rs) {
            for (VoucherDetails vd : entity.getDetails()) {
                vd.setVoucherId(entity.getId());
                vd.setAccountSetsId(entity.getAccountSetsId());
                vd.setCarryForward(entity.getCarryForward());
                if (vd.getDebitAmount() != null) {
                    debitAmount += vd.getDebitAmount();
                }
                if (vd.getCreditAmount() != null) {
                    creditAmount += vd.getCreditAmount();
                }
            }

            detailsMapper.batchInsert(entity.getDetails());

            //存储辅助项目
            for (VoucherDetails voucherDetails : entity.getDetails()) {
                voucherDetails.setSummary(StringUtils.trim(voucherDetails.getSummary()));
                voucherDetails.setSubjectCode(StringUtils.trim(voucherDetails.getSubjectCode()));
                int size;
                if ((size = voucherDetails.getAuxiliary().size()) > 0) {
                    List<VoucherDetailsAuxiliary> vdas = new ArrayList<>(size);
                    voucherDetails.getAuxiliary().forEach(acd -> {
                        VoucherDetailsAuxiliary vda = new VoucherDetailsAuxiliary();
                        vda.setVoucherDetailsId(voucherDetails.getId());
                        vda.setAccountingCategoryId(acd.getAccountingCategoryId());
                        vda.setAccountingCategoryDetailsId(acd.getId());
                        vdas.add(vda);
                    });

                    voucherDetailsAuxiliaryMapper.batchInsert(vdas);
                }
            }

            //更新总和
            entity.setCreditAmount(creditAmount);
            entity.setDebitAmount(debitAmount);
            baseMapper.updateById(entity);
        }


        return rs;
    }

    @Override
    public Voucher getOne(Wrapper<Voucher> queryWrapper) {
        List<Voucher> vouchers = baseMapper.selectVoucher(queryWrapper);
        if (vouchers.size() > 0) {
            return vouchers.get(0);
        }
        return null;
    }

    @Override
    @Transactional
    public boolean remove(Wrapper<Voucher> wrapper) {
        Voucher voucher = baseMapper.selectOne(wrapper);
        this.checkCheckOut(voucher.getAccountSetsId(), voucher.getVoucherYear(), voucher.getVoucherMonth());

        LambdaQueryWrapper<VoucherDetails> qw = Wrappers.lambdaQuery();
        qw.eq(VoucherDetails::getVoucherId, voucher.getId());
        detailsMapper.delete(qw);

        return baseMapper.delete(wrapper) > 0;
    }

    private void checkCode(Voucher entity) {
        LambdaQueryWrapper<Voucher> qw = Wrappers.lambdaQuery();
        qw.eq(Voucher::getCode, entity.getCode());
        qw.eq(Voucher::getWord, entity.getWord());
        qw.eq(Voucher::getVoucherYear, entity.getVoucherYear());
        qw.eq(Voucher::getVoucherMonth, entity.getVoucherMonth());
        qw.eq(Voucher::getAccountSetsId, entity.getAccountSetsId());

        if (entity.getId() != null) {
            qw.ne(Voucher::getId, entity.getId());
        }

        if (this.count(qw) > 0) {
            throw new ServiceException("亲,凭证字号[" + entity.getWord() + "-" + entity.getCode() + "]已经存在！");
        }
    }

    private void checkCheckOut(Integer accountSetsId, Integer year, Integer month) {
        LambdaQueryWrapper<Checkout> cqw = Wrappers.lambdaQuery();
        cqw.eq(Checkout::getAccountSetsId, accountSetsId);
        cqw.eq(Checkout::getCheckYear, year);
        cqw.eq(Checkout::getCheckMonth, month);
        cqw.eq(Checkout::getStatus, 2);

        if (checkoutMapper.selectCount(cqw) > 0) {
            throw new ServiceException("亲,期间已结账，不允许操作凭证！");
        }
    }

    private void setYearAndMonth(Voucher entity) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(entity.getVoucherDate());
        entity.setVoucherYear(calendar.get(Calendar.YEAR));
        entity.setVoucherMonth(calendar.get(Calendar.MONDAY) + 1);

        AccountSets accountSets = this.accountSetsMapper.selectById(entity.getAccountSetsId());
        Date d = DateUtil.getMonthEnd(accountSets.getEnableDate());
        Date d2 = DateUtil.getMonthEnd(entity.getVoucherDate());
        if (d.after(d2)) {
            throw new ServiceException("亲,日期不能小于账套启用日期：" + DateFormatUtils.format(d, "yyyy-MM-dd"));
        }
    }

    /**
     * 汇总和明细账
     *
     * @param accountSetsId
     * @param subjectId
     * @param accountDate
     * @param subjectCode
     * @param details
     * @return
     */
    private List<VoucherDetailVo> summary(Integer accountSetsId, Integer subjectId, Date accountDate, String subjectCode, Boolean showNumPrice, boolean details) {
        Subject subject = subjectMapper.selectById(subjectId);
        LambdaQueryWrapper<Subject> sqw = Wrappers.lambdaQuery();
        sqw.likeRight(Subject::getCode, subjectCode);
        sqw.eq(Subject::getAccountSetsId, accountSetsId);
        List<Subject> subjects = subjectMapper.selectList(sqw);
        List<Integer> sids = subjects.stream().map(Subject::getId).collect(Collectors.toList());

        List<VoucherDetailVo> initialBalance = baseMapper.selectAccountBookInitialBalance(accountSetsId, sids, DateUtil.getMonthBegin(accountDate));
        List<VoucherDetailVo> statistical = baseMapper.selectAccountBookStatistical(accountSetsId, subjectId, sids, DateUtil.getMonthEnd(accountDate));

        VoucherDetailVo init;
        //没有期初
        if (initialBalance.size() == 0) {
            init = new VoucherDetailVo();
            init.setVoucherDate(DateUtil.getMonthBegin(accountDate));
            init.setSummary("期初余额");
            init.setBalanceDirection("平");
            init.setSubjectName(subject.getCode() + "-" + subject.getName());
            init.setBalance(0d);
            initialBalance.add(init);
        } else {
            init = initialBalance.get(0);
            init.setVoucherDate(DateUtil.getMonthBegin(accountDate));
        }

        //科目明细
        if (details) {
            VoucherDetailVo pre = init;
            //初始数量余额
            pre.setNumBalance(pre.getNum());

            List<VoucherDetailVo> list = baseMapper.selectAccountBookDetails(accountSetsId, sids, accountDate);
            //计算余额
            for (int i = 0; i < list.size(); i++) {
                if (i > 0) {
                    pre = list.get(i - 1);
                }
                VoucherDetailVo vo = list.get(i);
                switch (vo.getBalanceDirection()) {
                    case "借":
                        if (vo.getDebitAmount() != null) {
                            vo.setBalance(DoubleValueUtil.getNotNullVal(pre.getBalance()) + DoubleValueUtil.getNotNullVal(vo.getDebitAmount()));
                        } else if (vo.getCreditAmount() != null) {
                            vo.setBalance(DoubleValueUtil.getNotNullVal(pre.getBalance()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount()));
                        }

                        if (vo.getNum() != null) {
                            vo.setNumBalance(DoubleValueUtil.getNotNullVal(pre.getNumBalance()) + vo.getNum());
                        } else {
                            vo.setNumBalance(pre.getNumBalance());
                        }
                        break;
                    case "贷":
                        if (vo.getDebitAmount() != null) {
                            vo.setBalance(DoubleValueUtil.getNotNullVal(pre.getBalance()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount()));
                        } else if (vo.getCreditAmount() != null) {
                            vo.setBalance(DoubleValueUtil.getNotNullVal(pre.getBalance()) + DoubleValueUtil.getNotNullVal(vo.getCreditAmount()));
                        }
                        if (vo.getNum() != null) {
                            vo.setNumBalance(DoubleValueUtil.getNotNullVal(pre.getNumBalance()) - vo.getNum());
                        } else {
                            vo.setNumBalance(pre.getNumBalance());
                        }
                        break;
                }
            }

            initialBalance.addAll(list);
        }

        //设置汇总余额
        Double balance = null;
        for (VoucherDetailVo vo : statistical) {
            double he = DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
            switch (vo.getBalanceDirection()) {
                case "借":
                    vo.setBalance(DoubleValueUtil.getNotNullVal(init.getBalance()) + he);
                    break;
                case "贷":
                    vo.setBalance(DoubleValueUtil.getNotNullVal(init.getBalance()) - he);
                    break;
            }
            if (vo.getSummary().equals("本期合计")) {
                balance = vo.getBalance();
            } else {
                vo.setBalance(DoubleValueUtil.getNotNullVal(balance, init.getBalance()));
            }
            vo.setNumBalance(vo.getNum());
            vo.setVoucherDate(DateUtil.getMonthEnd(accountDate));
        }

        initialBalance.addAll(statistical);
        return initialBalance;
    }
}





