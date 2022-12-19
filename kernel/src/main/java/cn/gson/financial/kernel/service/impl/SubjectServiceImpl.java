package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.common.DateUtil;
import cn.gson.financial.kernel.common.DoubleValueUtil;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.entity.VoucherTemplateDetails;
import cn.gson.financial.kernel.model.mapper.*;
import cn.gson.financial.kernel.model.vo.BalanceVo;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import cn.gson.financial.kernel.service.SubjectService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.AllArgsConstructor;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
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
public class SubjectServiceImpl extends ServiceImpl<SubjectMapper, Subject> implements SubjectService {

    private AccountSetsMapper accountSetsMapper;
    private VoucherMapper voucherMapper;
    private SubjectMapper subjectMapper;
    private VoucherDetailsMapper voucherDetailsMapper;
    private VoucherTemplateDetailsMapper voucherTemplateDetailsMapper;

    @Override
    public int batchInsert(List<Subject> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public List<SubjectVo> selectData(Wrapper<Subject> queryWrapper, boolean showAll) {
        QueryWrapper<Subject> qw = (QueryWrapper<Subject>) queryWrapper;
        qw.eq("status", 1);
        Map<Integer, Subject> subjectMap = baseMapper.selectList(qw).stream().collect(Collectors.toMap(Subject::getId, subject -> subject));
        List<Subject> list = baseMapper.selectNoChildrenSubject(qw);
        list.forEach(subject -> {
            if (subject.getLevel() != 1) {
                recursiveChildren(subjectMap, subject, subject.getParentId());
            }
        });

        if (showAll) {
            list.forEach(subject -> subjectMap.remove(subject.getId()));
            list.addAll(subjectMap.values());
        }

        return list.stream().sorted(Comparator.comparing(Subject::getCode)).map(subject -> {
            SubjectVo vo = new SubjectVo();
            BeanUtils.copyProperties(subject, vo);
            return vo;
        }).collect(Collectors.toList());
    }

    /**
     * 明细科目
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    @Override
    public List<Subject> accountBookList(Date accountDate, Integer accountSetsId, boolean showNumPrice) {
        List<Subject> subjectList = baseMapper.selectAccountBookList(accountDate != null ? DateUtil.getMonthEnd(accountDate) : null, accountSetsId, showNumPrice);

        Map<Integer, Subject> temp = new HashMap<>();
        subjectList.forEach(subject -> this.recursiveParent(temp, subject));
        return temp.values().stream().sorted(Comparator.comparing(Subject::getCode)).distinct().collect(Collectors.toList());
    }

    /**
     * 余额明细科目
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    @Override
    public List<Subject> balanceSubjectList(Date accountDate, Integer accountSetsId, boolean showNumPrice) {
        List<Subject> subjectList = this.accountBookList(DateUtil.getMonthEnd(accountDate), accountSetsId, showNumPrice);

        Map<Integer, Subject> temp = new HashMap<>();
        subjectList.forEach(subject -> this.recursiveParent(temp, subject));
        return temp.values().stream().sorted(Comparator.comparing(Subject::getCode)).distinct().collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void importVoucher(List<SubjectVo> voucherList, AccountSets accountSets) {
        AtomicInteger update = new AtomicInteger(0);
        AtomicInteger insert = new AtomicInteger(0);
        this.recursive(voucherList, update, insert, accountSets);
    }

    private void recursive(@NonNull List<SubjectVo> voucherList, AtomicInteger update, AtomicInteger insert, AccountSets accountSets) {
        for (SubjectVo vo : voucherList) {
            if (vo.getId() != null) {
                if (this.checkUse(vo.getId())) {
                    continue;
                }

                this.updateById(vo);
                update.incrementAndGet();
                if (!vo.getChildren().isEmpty()) {
                    vo.getChildren().forEach(s -> s.setParentId(vo.getId()));
                    this.recursive(vo.getChildren(), update, insert, accountSets);
                }
            } else {
                if (accountSets.getAccountingStandards() == (short) 0 && vo.getLevel() == (short) 1) {
                    continue;
                }

                //一般纳税人
                this.save(vo);
                insert.incrementAndGet();
                if (!vo.getChildren().isEmpty()) {
                    vo.getChildren().forEach(s -> s.setParentId(vo.getId()));
                    this.recursive(vo.getChildren(), update, insert, accountSets);
                }
            }
        }
    }

    /**
     * 科目余额
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    @Override
    public List<BalanceVo> subjectBalance(Date accountDate, Integer accountSetsId, boolean showNumPrice) {
        //当前查询账套
        AccountSets accountSets = accountSetsMapper.selectById(accountSetsId);
        List<Subject> subjects = this.accountBookList(null, accountSetsId, showNumPrice);
        //转换为余额对象
        Map<Integer, BalanceVo> sbvMap = subjects.stream().collect(Collectors.toMap(Subject::getId, subject -> {
            BalanceVo sbv = new BalanceVo();
            sbv.setSubjectId(subject.getId());
            sbv.setCode(subject.getCode());
            sbv.setParentId(subject.getParentId());
            sbv.setName(subject.getName());
            sbv.setLevel(subject.getLevel());
            sbv.setUnit(subject.getUnit());
            sbv.setBalanceDirection(subject.getBalanceDirection().toString());
            return sbv;
        }));

        //原始期初余额
        if (sbvMap.isEmpty()) {
            return new ArrayList<>();
        }


        //对比账套时间，判断是否是初始账套时间
        if (!DateFormatUtils.format(accountSets.getEnableDate(), "yyyyMM").equals(DateFormatUtils.format(accountDate, "yyyyMM"))) {
            List<VoucherDetailVo> details = voucherMapper.selectSubjectDetail(sbvMap.keySet(), accountSetsId, DateUtil.getMonthBegin(accountDate), null, showNumPrice);
            details.forEach(vd -> {
                if (sbvMap.containsKey(vd.getSubjectId())) {
                    BalanceVo sbv = sbvMap.get(vd.getSubjectId());
                    Double val = null;
                    switch (sbv.getBalanceDirection()) {
                        case "借":
                            val = DoubleValueUtil.getNotNullVal(vd.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vd.getCreditAmount());
                            break;
                        case "贷":
                            val = DoubleValueUtil.getNotNullVal(vd.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vd.getDebitAmount());
                            break;
                    }
                    sbv.setBeginningActiveBalance(val);
                }
            });
        } else {
            LambdaQueryWrapper<VoucherDetails> qwi = Wrappers.lambdaQuery();
            qwi.eq(VoucherDetails::getAccountSetsId, accountSetsId);
            qwi.in(VoucherDetails::getSubjectId, sbvMap.keySet());
            qwi.isNull(VoucherDetails::getVoucherId);
            qwi.and(wrapper -> {
                wrapper.or(true).isNotNull(VoucherDetails::getCreditAmount);
                wrapper.or(true).isNotNull(VoucherDetails::getDebitAmount);
                return wrapper;
            });
            this.voucherDetailsMapper.selectList(qwi).forEach(ib -> {
                if (sbvMap.containsKey(ib.getSubjectId())) {
                    sbvMap.get(ib.getSubjectId()).setBeginningBalance(DoubleValueUtil.getNotNullVal(ib.getCreditAmount(), ib.getDebitAmount()));
                }
            });
        }

        //本期发生额
        List<VoucherDetailVo> details = voucherMapper.selectSubjectDetail(sbvMap.keySet(), accountSetsId, DateUtil.getMonthBegin(accountDate), DateUtil.getMonthEnd(accountDate), showNumPrice);
        details.forEach(vd -> {
            if (sbvMap.containsKey(vd.getSubjectId())) {
                BalanceVo sbv = sbvMap.get(vd.getSubjectId());
                sbv.setCurrentCreditAmount(vd.getCreditAmount());
                sbv.setCurrentDebitAmount(vd.getDebitAmount());
                if (showNumPrice && vd.getBalanceDirection() != null) {
                    switch (vd.getBalanceDirection()) {
                        case "借":
                            sbv.setCurrentDebitAmountNum(vd.getNum());
                            break;
                        case "贷":
                            sbv.setCurrentCreditAmountNum(vd.getNum());
                            break;
                    }
                }
            }
        });

        //合计
        BalanceVo aCombined = new BalanceVo();
        aCombined.setName("合计");
        //计算期末
        List<BalanceVo> balanceVos = sbvMap.values().stream().sorted(Comparator.comparing(BalanceVo::getCode)).collect(Collectors.toList());
        for (BalanceVo vo : balanceVos) {
            //期初
            Double bb = DoubleValueUtil.getNotNullVal(vo.getBeginningBalance());
            //本期借贷金额
            Double cc = DoubleValueUtil.getNotNullVal(vo.getCurrentCreditAmount());
            Double cd = DoubleValueUtil.getNotNullVal(vo.getCurrentDebitAmount());
            //本期借贷数量
            Double ccNum = DoubleValueUtil.getNotNullVal(vo.getCurrentCreditAmountNum());
            Double cdNum = DoubleValueUtil.getNotNullVal(vo.getCurrentDebitAmountNum());

            //根据方向计算余额
            switch (vo.getBalanceDirection()) {
                case "借":
                    vo.setEndingActiveBalance(bb + cd - cc);
                    break;
                case "贷":
                    vo.setEndingActiveBalance(bb - cd + cc);
                    break;
            }

            if (showNumPrice) {
                switch (vo.getBalanceDirection()) {
                    case "借":
                        vo.setEndingDebitBalanceNum(cdNum - ccNum);
                        break;
                    case "贷":
                        vo.setEndingCreditBalanceNum(ccNum - cdNum);
                        break;
                }
            }

            //计算合计列
            aCombined.setBeginningCreditBalance(vo.getBeginningCreditBalance());
            aCombined.setBeginningDebitBalance(vo.getBeginningDebitBalance());

            aCombined.setCurrentCreditAmount(vo.getCurrentCreditAmount());
            aCombined.setCurrentCreditAmountNum(vo.getCurrentCreditAmountNum());
            aCombined.setCurrentDebitAmount(vo.getCurrentDebitAmount());
            aCombined.setCurrentDebitAmountNum(vo.getCurrentDebitAmountNum());

            aCombined.setEndingCreditBalance(vo.getEndingCreditBalance());
            aCombined.setEndingCreditBalanceNum(vo.getEndingCreditBalanceNum());
            aCombined.setEndingDebitBalance(vo.getEndingDebitBalance());
            aCombined.setEndingDebitBalanceNum(vo.getEndingDebitBalanceNum());
        }

        //计算父节点
        for (int i = balanceVos.size() - 1; i > 0; i--) {
            BalanceVo vo = balanceVos.get(i);
            if (vo.getLevel() != 1) {
                BalanceVo parent = sbvMap.get(vo.getParentId());
                if (parent != null) {
                    parent.setBeginningBalance(vo.getBeginningBalance());
                    parent.setCurrentDebitAmount(vo.getCurrentDebitAmount());
                    parent.setCurrentDebitAmountNum(vo.getCurrentDebitAmountNum());
                    parent.setCurrentCreditAmount(vo.getCurrentCreditAmount());
                    parent.setCurrentCreditAmountNum(vo.getCurrentCreditAmountNum());
                    if (vo.getEndingCreditBalance() != null) {
                        parent.setEndingCreditBalance(vo.getEndingCreditBalance());
                    }
                    if (vo.getEndingDebitBalance() != null) {
                        parent.setEndingCreditBalance(vo.getEndingDebitBalance());
                    }
                }
            }
        }

        if (balanceVos.size() > 0) {
            //过滤掉空行
            balanceVos = balanceVos.stream().filter(vo ->
                    (vo.getBeginningBalance() != null && vo.getBeginningBalance() != 0) ||
                            (vo.getEndingBalance() != null && vo.getEndingBalance() != 0) ||
                            (vo.getCurrentDebitAmount() != null && vo.getCurrentDebitAmount() != 0) ||
                            (vo.getCurrentCreditAmount() != null && vo.getCurrentCreditAmount() != 0)
            ).collect(Collectors.toList());
            balanceVos.add(aCombined);
        }

        return balanceVos;
    }

    /**
     * 科目汇总
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    @Override
    public List subjectSummary(Date accountDate, Integer accountSetsId, boolean showNumPrice) {
        List<Subject> subjects = this.accountBookList(accountDate, accountSetsId, showNumPrice);
        //转换为余额对象
        Map<Integer, BalanceVo> sbvMap = subjects.stream().collect(Collectors.toMap(Subject::getId, subject -> {
            BalanceVo sbv = new BalanceVo();
            sbv.setSubjectId(subject.getId());
            sbv.setCode(subject.getCode());
            sbv.setUnit(subject.getUnit());
            sbv.setParentId(subject.getParentId());
            sbv.setName(subject.getName());
            sbv.setLevel(subject.getLevel());
            sbv.setBalanceDirection(subject.getBalanceDirection().toString());
            return sbv;
        }));

        if (sbvMap.isEmpty()) {
            return new ArrayList<>();
        }

        //本期发生额
        List<VoucherDetailVo> details = voucherMapper.selectSubjectDetail(sbvMap.keySet(), accountSetsId, DateUtil.getMonthBegin(accountDate), DateUtil.getMonthEnd(accountDate), showNumPrice);
        details.forEach(vd -> {
            if (sbvMap.containsKey(vd.getSubjectId())) {
                BalanceVo sbv = sbvMap.get(vd.getSubjectId());
                if (showNumPrice) {
                    if (vd.getBalanceDirection() != null) {
                        switch (vd.getBalanceDirection()) {
                            case "借":
                                sbv.setCurrentDebitAmount(vd.getDebitAmount());
                                sbv.setCurrentDebitAmountNum(vd.getNum());
                                break;
                            case "贷":
                                sbv.setCurrentCreditAmount(vd.getCreditAmount());
                                sbv.setCurrentCreditAmountNum(vd.getNum());
                                break;
                        }
                    }
                } else {
                    sbv.setCurrentCreditAmount(vd.getCreditAmount());
                    sbv.setCurrentDebitAmount(vd.getDebitAmount());
                }
            }
        });

        //合计
        BalanceVo aCombined = new BalanceVo();
        aCombined.setName("合计");
        //计算期末
        List<BalanceVo> balanceVos = sbvMap.values().stream().sorted(Comparator.comparing(BalanceVo::getCode)).collect(Collectors.toList());
        for (BalanceVo vo : balanceVos) {
            aCombined.setCurrentCreditAmount(vo.getCurrentCreditAmount());
            aCombined.setCurrentCreditAmountNum(vo.getCurrentCreditAmountNum());
            aCombined.setCurrentDebitAmount(vo.getCurrentDebitAmount());
            aCombined.setCurrentDebitAmountNum(vo.getCurrentDebitAmountNum());
        }

        //计算父节点
        for (int i = balanceVos.size() - 1; i > 0; i--) {
            BalanceVo vo = balanceVos.get(i);
            if (vo.getLevel() != 1) {
                BalanceVo parent = sbvMap.get(vo.getParentId());
                if (parent != null) {
                    parent.setCurrentDebitAmount(vo.getCurrentDebitAmount());
                    parent.setCurrentDebitAmountNum(vo.getCurrentDebitAmountNum());
                    parent.setCurrentCreditAmount(vo.getCurrentCreditAmount());
                    parent.setCurrentCreditAmountNum(vo.getCurrentCreditAmountNum());
                }
            }
        }

        if (balanceVos.size() > 0) {
            balanceVos.add(aCombined);
        }

        return balanceVos;
    }

    private void recursiveParent(Map<Integer, Subject> temp, Subject subject) {
        temp.put(subject.getId(), subject);
        if (subject.getLevel() != 1) {
            if (!temp.containsKey(subject.getParentId())) {
                Subject sbj = baseMapper.selectById(subject.getParentId());
                this.recursiveParent(temp, sbj);
            }
        }
    }

    private void recursiveChildren(Map<Integer, Subject> subjectMap, Subject subject, int parentId) {
        Subject parent = subjectMap.get(parentId);
        subject.setName(parent.getName() + "-" + subject.getName());
        if (parent.getLevel() != 1) {
            recursiveChildren(subjectMap, subject, parent.getParentId());
        }
    }

    public List<SubjectVo> listVo(Wrapper<Subject> queryWrapper) {
        QueryWrapper<Subject> qw = (QueryWrapper<Subject>) queryWrapper;
        qw.orderByAsc("code");
        return baseMapper.selectSubjectVo(queryWrapper);
    }

    /**
     * 检查科目是否已经被使用
     *
     * @param id
     * @return
     */
    @Override
    public Boolean checkUse(Integer id) {
        LambdaQueryWrapper<VoucherDetails> vdqw = Wrappers.lambdaQuery();
        vdqw.eq(VoucherDetails::getSubjectId, id);
        boolean vd = voucherDetailsMapper.selectCount(vdqw) == 0;

        LambdaQueryWrapper<VoucherTemplateDetails> vtdqw = Wrappers.lambdaQuery();
        vtdqw.eq(VoucherTemplateDetails::getSubjectId, id);
        boolean vtd = voucherTemplateDetailsMapper.selectCount(vtdqw) == 0;

        return !(vd && vtd);
    }

    /**
     * 科目余额
     *
     * @param accountSetsId
     * @param subjectId
     * @param categoryId
     * @param categoryDetailsId
     * @return
     */
    @Override
    public Double balance(Integer accountSetsId, Integer subjectId, Integer categoryId, Integer categoryDetailsId) {
        LambdaQueryWrapper<VoucherDetails> ibqw = Wrappers.lambdaQuery();
        ibqw.eq(VoucherDetails::getSubjectId, subjectId);
        ibqw.eq(VoucherDetails::getAccountSetsId, accountSetsId);
        ibqw.isNull(VoucherDetails::getVoucherId);

        List<VoucherDetails> ibs = this.voucherDetailsMapper.selectList(ibqw);
        VoucherDetails ib = null;
        if (ibs.size() > 0) {
            ib = ibs.get(0);
            for (int i = 1; i < ibs.size(); i++) {
                double creditAmount = Optional.ofNullable(ib.getCreditAmount()).orElse(0d) + Optional.ofNullable(ibs.get(i).getCreditAmount()).orElse(0d);
                double debitAmount = Optional.ofNullable(ib.getDebitAmount()).orElse(0d) + Optional.ofNullable(ibs.get(i).getDebitAmount()).orElse(0d);
                ib.setCreditAmount(creditAmount);
                ib.setDebitAmount(debitAmount);
            }
        }


        List<VoucherDetailVo> vds = voucherDetailsMapper.selectBalanceData(accountSetsId, subjectId, categoryId, categoryDetailsId);
        double balance = 0d;
        if (!vds.isEmpty()) {
            VoucherDetailVo vo = vds.get(0);
            if (vo != null) {
                if (vo.getBalanceDirection().equals("借")) {
                    balance = DoubleValueUtil.getNotNullVal(vo.getDebitAmount()) - DoubleValueUtil.getNotNullVal(vo.getCreditAmount());
                } else {
                    balance = DoubleValueUtil.getNotNullVal(vo.getCreditAmount()) - DoubleValueUtil.getNotNullVal(vo.getDebitAmount());
                }
            }
        }

        //TODO 期初暂时没有辅助期初，categoryId == null过滤掉辅助
        if (ib != null && categoryId == null) {
            balance += DoubleValueUtil.getNotNullVal(ib.getDebitAmount(), ib.getCreditAmount());
        }

        return balance;
    }

    /**
     * 过滤出所有没有子节点的科目
     *
     * @param accountSetsId
     * @return
     */
    @Override
    public List<Integer> leafList(Integer accountSetsId) {
        return this.baseMapper.selectLeaf(accountSetsId);
    }

    @Override
    public boolean save(Subject entity) {
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.eq(Subject::getAccountSetsId, entity.getAccountSetsId());
        qw.eq(Subject::getName, entity.getName());
        qw.eq(Subject::getParentId, entity.getParentId());

        if (this.count(qw) > 0) {
            throw new ServiceException("科目名称已经存在！");
        }

        qw = Wrappers.lambdaQuery();
        qw.eq(Subject::getAccountSetsId, entity.getAccountSetsId());
        qw.eq(Subject::getCode, entity.getCode());

        if (this.count(qw) > 0) {
            throw new ServiceException("科目编码已经存在！");
        }

        return super.save(entity);
    }

    @Override
    public boolean remove(Wrapper<Subject> wrapper) {
        if (this.checkUse(getOne(wrapper).getId())) {
            throw new ServiceException("科目已被使用，不能删除！");
        }
        return super.remove(wrapper);
    }
}