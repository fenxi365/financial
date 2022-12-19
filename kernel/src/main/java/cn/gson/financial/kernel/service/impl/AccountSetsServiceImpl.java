package cn.gson.financial.kernel.service.impl;

import cn.gson.financial.kernel.aliyuncs.SmsService;
import cn.gson.financial.kernel.common.Roles;
import cn.gson.financial.kernel.exception.ServiceException;
import cn.gson.financial.kernel.model.entity.Currency;
import cn.gson.financial.kernel.model.entity.*;
import cn.gson.financial.kernel.model.mapper.*;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import cn.gson.financial.kernel.service.AccountSetsService;
import cn.gson.financial.kernel.service.SubjectService;
import cn.gson.financial.kernel.service.VoucherDetailsService;
import cn.gson.financial.kernel.service.VoucherTemplateDetailsService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
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
@RequiredArgsConstructor
public class AccountSetsServiceImpl extends ServiceImpl<AccountSetsMapper, AccountSets> implements AccountSetsService {

    private final UserAccountSetsMapper userAccountSetsMapper;

    private final SmsService smsService;

    private final UserMapper userMapper;

    private final SubjectMapper subjectMapper;

    private final SubjectService subjectService;

    private final VoucherDetailsService voucherDetailsService;

    private final VoucherTemplateDetailsService voucherTemplateDetailsService;

    private final AccountingCategoryMapper accountingCategoryMapper;

    private final CurrencyMapper currencyMapper;

    private final CheckoutMapper checkoutMapper;

    private final VoucherWordMapper voucherWordMapper;

    private final ReportTemplateMapper reportTemplateMapper;

    private final ReportTemplateItemsMapper reportTemplateItemsMapper;

    private final ReportTemplateItemsFormulaMapper reportTemplateItemsFormulaMapper;

    @Value("${aliyun.sms.signature}")
    private String smsSignature;

    @Value("${aliyun.sms.template-code.register}")
    private String registerCode;

    @Override
    public int batchInsert(List<AccountSets> list) {
        return baseMapper.batchInsert(list);
    }

    @Override
    public List<AccountSets> myAccountSets(Integer uid) {
        return baseMapper.selectMyAccountSets(uid);
    }

    @Override
    public void addUser(Integer accountSetsId, String mobile, String role) {
        LambdaQueryWrapper<User> uqw = Wrappers.lambdaQuery();
        uqw.eq(User::getMobile, mobile);
        User user = this.userMapper.selectOne(uqw);
        if (user == null) {
            throw new ServiceException("此手机号未注册！", 501);
        }

        LambdaQueryWrapper<UserAccountSets> uaqw = Wrappers.lambdaQuery();
        uaqw.eq(UserAccountSets::getAccountSetsId, accountSetsId);
        uaqw.eq(UserAccountSets::getUserId, user.getId());
        if (userAccountSetsMapper.selectCount(uaqw) > 0) {
            throw new ServiceException("亲，此用户已经拥有此账套权限！", 502);
        }

        //添加关系
        UserAccountSets userAccountSets = new UserAccountSets();
        userAccountSets.setAccountSetsId(accountSetsId);
        userAccountSets.setUserId(user.getId());
        userAccountSets.setRoleType(Roles.valueOf(role).name());
        userAccountSetsMapper.insert(userAccountSets);

        //设置用户当前账簿未新添加账簿
        user.setAccountSetsId(accountSetsId);
        this.userMapper.updateById(user);
    }

    @Override
    @Transactional
    public User addNewUser(Integer accountSetsId, String mobile, String role) {
        User user = new User();
        user.setMobile(mobile);
        user.setNickname(Roles.valueOf(role).display);
        user.setRealName(Roles.valueOf(role).display + mobile.substring(7));
        user.setAccountSetsId(accountSetsId);
        user.setInitPassword(RandomStringUtils.randomNumeric(6));
        user.setPassword(DigestUtils.sha256Hex(user.getInitPassword()));
        this.userMapper.insert(user);

        UserAccountSets userAccountSets = new UserAccountSets();
        userAccountSets.setAccountSetsId(accountSetsId);
        userAccountSets.setUserId(user.getId());
        userAccountSets.setRoleType(Roles.valueOf(role).name());
        this.userAccountSetsMapper.insert(userAccountSets);

        try {
            SmsService.SmsBody smsBody = new SmsService.SmsBody(mobile, smsSignature, registerCode);
            Map<String, String> params = new HashMap<>(1);
            params.put("password", user.getInitPassword());
            smsBody.setTemplateParam(params);
            this.smsService.send(smsBody);
        } catch (Exception e) {
            log.error("默认密码发送失败：" + user.getMobile(), e);
        }
        return user;
    }

    @Override
    @Transactional
    public void removeUser(Integer accountSetsId, Integer uid) {
        LambdaQueryWrapper<UserAccountSets> uaqw = Wrappers.lambdaQuery();
        uaqw.eq(UserAccountSets::getAccountSetsId, accountSetsId);
        uaqw.eq(UserAccountSets::getUserId, uid);
        this.userAccountSetsMapper.delete(uaqw);

        //重置用户默认账套
        User user = this.userMapper.selectById(uid);
        if (user.getAccountSetsId().equals(accountSetsId)) {
            uaqw = Wrappers.lambdaQuery();
            uaqw.eq(UserAccountSets::getUserId, uid);
            List<UserAccountSets> accountSets = this.userAccountSetsMapper.selectList(uaqw);
            if (accountSets.size() > 0) {
                user.setAccountSetsId(accountSets.get(0).getAccountSetsId());
            } else {
                user.setAccountSetsId(null);
            }
            this.userMapper.updateById(user);
        }
    }

    @Override
    public void updateUserRole(Integer accountSetsId, Integer uid, String role) {
        LambdaQueryWrapper<UserAccountSets> uaqw = Wrappers.lambdaQuery();
        uaqw.eq(UserAccountSets::getAccountSetsId, accountSetsId);
        uaqw.eq(UserAccountSets::getUserId, uid);
        UserAccountSets userAccountSets = this.userAccountSetsMapper.selectOne(uaqw);
        userAccountSets.setRoleType(Roles.valueOf(role).name());
        this.userAccountSetsMapper.update(userAccountSets, uaqw);
    }

    @Override
    @Transactional
    public void handOver(Integer accountSetsId, Integer currentUserId, String mobile) {
        AccountSets accountSets = this.baseMapper.selectById(accountSetsId);

        //获取手机号的用户信息
        LambdaQueryWrapper<User> uqw = Wrappers.lambdaQuery();
        uqw.eq(User::getMobile, mobile);
        User user = this.userMapper.selectOne(uqw);

        boolean relate = true;
        if (user == null) {
            //用户不存在则创建用户并关联
            user = this.addNewUser(accountSetsId, mobile, Roles.Manager.name());
        } else {
            LambdaQueryWrapper<UserAccountSets> uaqw = Wrappers.lambdaQuery();
            uaqw.eq(UserAccountSets::getAccountSetsId, accountSetsId);
            uaqw.eq(UserAccountSets::getUserId, user.getId());

            relate = this.userAccountSetsMapper.selectCount(uaqw) > 0;

            //如果用户当前账套，则需要修改
            if (user.getAccountSetsId().equals(accountSetsId)) {
                uaqw = Wrappers.lambdaQuery();
                uaqw.eq(UserAccountSets::getUserId, user.getId());
                uaqw.ne(UserAccountSets::getAccountSetsId, accountSetsId);
                //当前用户拥有的所有账套
                List<UserAccountSets> userAccountSets = this.userAccountSetsMapper.selectList(uaqw);

                if (userAccountSets.size() > 0) {
                    user.setAccountSetsId(userAccountSets.get(0).getAccountSetsId());
                    this.userMapper.updateById(user);
                }
            }
        }

        //用户未关联是，进行关联
        if (!relate) {
            UserAccountSets userAccountSets = new UserAccountSets();
            userAccountSets.setAccountSetsId(accountSetsId);
            userAccountSets.setUserId(user.getId());
            userAccountSets.setRoleType(Roles.Manager.name());
            this.userAccountSetsMapper.insert(userAccountSets);
        }

        //修改账套拥有者
        accountSets.setCreatorId(user.getId());
        this.baseMapper.updateById(accountSets);

        //解除用户和账套的关联
        LambdaQueryWrapper<UserAccountSets> uaqw = Wrappers.lambdaQuery();
        uaqw.eq(UserAccountSets::getAccountSetsId, accountSetsId);
        uaqw.eq(UserAccountSets::getUserId, currentUserId);
        this.userAccountSetsMapper.delete(uaqw);
    }

    /**
     * 更新科目编码设置
     *
     * @param accountSetsId
     * @param encoding
     * @param newEncoding
     */
    @Override
    @Transactional
    public void updateEncode(Integer accountSetsId, String encoding, String newEncoding) {
        AccountSets accountSets = this.getById(accountSetsId);
        accountSets.setEncoding(newEncoding);
        this.baseMapper.updateById(accountSets);

        //更新所有科目编码
        LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
        qw.eq(Subject::getAccountSetsId, accountSetsId);
        List<Subject> subjects = this.subjectMapper.selectList(qw);
        List<Integer> newModel = Arrays.stream(newEncoding.split("-")).map(s -> Integer.parseInt(s)).collect(Collectors.toList());
        List<Integer> model = Arrays.stream(encoding.split("-")).map(s -> Integer.parseInt(s)).collect(Collectors.toList());
        //变更后的code和原始code字典
        Map<String, String> codeMap = new HashMap<>(subjects.size());

        subjects.forEach(subject -> {
            String code = this.updateCode(subject.getCode(), model, newModel);
            codeMap.put(subject.getCode(), code);
            subject.setCode(code);
        });

        this.subjectService.updateBatchById(subjects);

        //更新凭证里面所有code
        this.updateVoucherDetailCode(accountSetsId, codeMap);
        //更新模板凭证里面的所有code
        this.updateVoucherTempDetailCode(accountSetsId, codeMap);

    }

    @Override
    @Transactional
    public boolean save(AccountSets entity) {
        LambdaQueryWrapper<AccountSets> qw = Wrappers.lambdaQuery();
        qw.eq(AccountSets::getCompanyName, entity.getCompanyName());
        qw.eq(AccountSets::getCreatorId, entity.getCreatorId());

        if (this.count(qw) > 0) {
            throw new ServiceException("单位名称已经存在！");
        }

        boolean rs = super.save(entity);
        if (rs) {
            //加入关联表
            UserAccountSets userAccountSets = new UserAccountSets();
            userAccountSets.setAccountSetsId(entity.getId());
            userAccountSets.setUserId(entity.getCreatorId());
            userAccountSets.setRoleType(Roles.Manager.name());
            userAccountSetsMapper.insert(userAccountSets);

            //当前用户更新默认账套
            User user = new User();
            user.setId(entity.getCreatorId());
            user.setAccountSetsId(entity.getId());
            userMapper.updateById(user);

            //初始化数据
            this.initAccountingCategory(entity);
            this.initCurrency(entity);
            this.initVoucherWord(entity);
            this.initSubject(entity);
            try {
                this.initReport(entity);
            } catch (IOException e) {
                throw new ServiceException("初始化报表失败！", e);
            }

            //初始化结转状态
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(entity.getEnableDate());
            Checkout checkout = new Checkout();
            checkout.setAccountSetsId(entity.getId());
            checkout.setCheckYear(calendar.get(Calendar.YEAR));
            checkout.setCheckMonth(calendar.get(Calendar.MONDAY) + 1);
            checkoutMapper.insert(checkout);
        }
        return rs;
    }

    @Override
    public boolean update(AccountSets entity, Wrapper<AccountSets> updateWrapper) {
        AccountSets old = this.getById(entity.getId());
        //如果修改了初始账套日期，需要同步更新
        if (!DateFormatUtils.format(old.getEnableDate(), "yyyyMM").equals(DateFormatUtils.format(entity.getEnableDate(), "yyyyMM"))) {
            LambdaQueryWrapper<Checkout> cqw = Wrappers.lambdaQuery();
            cqw.eq(Checkout::getAccountSetsId, entity.getId());
            cqw.eq(Checkout::getCheckYear, DateFormatUtils.format(old.getEnableDate(), "yyyy"));
            cqw.eq(Checkout::getCheckMonth, DateFormatUtils.format(old.getEnableDate(), "M"));

            Checkout checkout = this.checkoutMapper.selectOne(cqw);
            checkout.setCheckYear(Integer.parseInt(DateFormatUtils.format(entity.getEnableDate(), "yyyy")));
            checkout.setCheckMonth(Integer.parseInt(DateFormatUtils.format(entity.getEnableDate(), "M")));
            this.checkoutMapper.updateById(checkout);
            entity.setCurrentAccountDate(entity.getEnableDate());
        }
        return super.update(entity, updateWrapper);
    }

    @Override
    @Transactional
    public boolean remove(Wrapper<AccountSets> wrapper) {
        AccountSets accountSets = this.getOne(wrapper);
        LambdaQueryWrapper<UserAccountSets> uasQw = Wrappers.lambdaQuery();
        uasQw.eq(UserAccountSets::getAccountSetsId, accountSets.getId());
        userAccountSetsMapper.delete(uasQw);

        LambdaQueryWrapper<User> uQw = Wrappers.lambdaQuery();
        uQw.eq(User::getAccountSetsId, accountSets.getId());

        List<User> userList = userMapper.selectList(uQw);
        for (User user : userList) {
            uasQw = Wrappers.lambdaQuery();
            uasQw.eq(UserAccountSets::getUserId, user.getId());
            uasQw.last("limit 1");
            UserAccountSets one = userAccountSetsMapper.selectOne(uasQw);
            if (one != null) {
                user.setAccountSetsId(one.getAccountSetsId());
            } else {
                one.setAccountSetsId(null);
            }

            userMapper.updateById(user);
        }

        return this.baseMapper.deleteById(accountSets.getId()) > 0;
    }

    /**
     * 初始化核算类别
     *
     * @param entity
     */
    private void initAccountingCategory(AccountSets entity) {
        String[] categories = new String[]{"客户", "供应商", "职员", "部门", "项目", "存货", "现金流"};
        String[] categoriesCols = new String[]{"助记码,客户类别,经营地址,联系人,手机,税号", "助记码,供应商类别,经营地址,联系人,手机,税号", "助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期", "助记码,负责人,手机,成立日期,撤销日期", "助记码,负责部门,负责人,手机,开始日期,验收日期", "助记码,规格型号,存货类别,计量单位,启用日期,停用日期", "现金流类别,助记码"};
        List<AccountingCategory> categoryList = new ArrayList<>(categories.length);
        for (int i = 0; i < categories.length; i++) {
            AccountingCategory ac = new AccountingCategory();
            ac.setCanEdit(false);
            ac.setSystemDefault(true);
            ac.setAccountSetsId(entity.getId());
            ac.setName(categories[i]);
            ac.setCustomColumns(categoriesCols[i]);

            categoryList.add(ac);
        }

        accountingCategoryMapper.batchInsert(categoryList);
    }

    /**
     * 初始化科目
     *
     * @param entity
     */
    private void initSubject(AccountSets entity) {
        try {
            if (entity.getAccountingStandards() == 0) {
                List<SubjectVo> smallEnterpriseSubject = JSONArray.parseArray(IOUtils.toString(AccountSetsServiceImpl.class.getResourceAsStream("/subject/small_enterprise.json")), SubjectVo.class);
                this.recursiveSubject(smallEnterpriseSubject, entity);
            } else {
                List<SubjectVo> enterpriseSubject = JSONArray.parseArray(IOUtils.toString(AccountSetsServiceImpl.class.getResourceAsStream("/subject/enterprise.json")), SubjectVo.class);
                this.recursiveSubject(enterpriseSubject, entity);
            }
        } catch (Exception e) {
            log.error("加载默认科目失败....", e);
            throw new ServiceException("初始化默认科目失败");
        }
    }

    private void recursiveSubject(List<SubjectVo> subjects, AccountSets entity) {
        subjects.forEach(subject -> subject.setAccountSetsId(entity.getId()));
        subjects.forEach(subject -> {
            subjectMapper.insert(subject);

            if (subject.getChildren() != null && subject.getChildren().size() > 0) {
                subject.getChildren().forEach(subject1 -> subject1.setParentId(subject.getId()));
                this.recursiveSubject(subject.getChildren(), entity);
            }
        });
    }

    /**
     * 初始化凭证字
     *
     * @param entity
     */
    private void initVoucherWord(AccountSets entity) {
        VoucherWord word = new VoucherWord();
        word.setWord("记");
        word.setPrintTitle("记账凭证");
        word.setIsDefault(true);
        word.setAccountSetsId(entity.getId());
        voucherWordMapper.insert(word);

        word.setWord("收");
        word.setPrintTitle("收款凭证");
        word.setIsDefault(false);
        voucherWordMapper.insert(word);

        word.setWord("付");
        word.setPrintTitle("付款凭证");
        voucherWordMapper.insert(word);

        word.setWord("转");
        word.setPrintTitle("转账凭证");
        voucherWordMapper.insert(word);
    }

    /**
     * 初始化本币
     *
     * @param entity
     */
    private void initCurrency(AccountSets entity) {
        Currency currency = new Currency();
        currency.setCode("RMB");
        currency.setName("人民币");
        currency.setExchangeRate(1d);
        currency.setLocalCurrency(true);
        currency.setAccountSetsId(entity.getId());
        currencyMapper.insert(currency);
    }

    /**
     * 初始报表模板
     *
     * @param entity
     */
    private void initReport(AccountSets entity) throws IOException {
        String[] fileNames = {"lrb.json", "xjllb.json", "zcfzb.json"};
        for (String fileName : fileNames) {
            JSONObject lrb = JSONObject.parseObject(IOUtils.toString(AccountSetsServiceImpl.class.getResourceAsStream("/report/standard" + entity.getAccountingStandards() + "/" + fileName)));
            ReportTemplate rt = new ReportTemplate();
            rt.setName(lrb.getString("name"));
            rt.setAccountSetsId(entity.getId());
            rt.setTemplateKey(lrb.getString("templateKey"));
            rt.setType(lrb.getInteger("type"));
            //新增报表
            reportTemplateMapper.insert(rt);

            JSONArray items = lrb.getJSONArray("items");
            if (items != null && !items.isEmpty()) {
                Map<Integer, JSONObject> objectMap = items.stream().collect(Collectors.toMap(map -> ((JSONObject) map).getInteger("id"), map -> (JSONObject) map));
                for (int i = 0, size = items.size(); i < size; i++) {
                    JSONObject item = items.getJSONObject(i);
                    ReportTemplateItems rti = new ReportTemplateItems();
                    rti.setTemplateId(rt.getId());
                    rti.setTitle(item.getString("title"));
                    Integer parentId = item.getInteger("parentId");
                    if (parentId != null) {
                        rti.setParentId(objectMap.get(parentId).getInteger("pid"));
                    }
                    rti.setLineNum(item.getInteger("lineNum"));
                    rti.setType(item.getInteger("type"));
                    rti.setSources(item.getInteger("sources"));
                    rti.setLevel(item.getInteger("level"));
                    rti.setIsBolder(item.getBoolean("isBolder"));
                    rti.setIsFolding(item.getBoolean("isFolding"));
                    rti.setIsClassified(item.getBoolean("isClassified"));
                    rti.setPos(item.getInteger("pos"));

                    reportTemplateItemsMapper.insert(rti);
                    item.put("pid", rti.getId());
                    //公式
                    JSONArray formulas = item.getJSONArray("formulas");
                    if (formulas != null && formulas.size() > 0) {
                        for (int j = 0, size2 = formulas.size(); j < size2; j++) {
                            ReportTemplateItemsFormula formula = formulas.getObject(j, ReportTemplateItemsFormula.class);
                            formula.setTemplateId(rt.getId());
                            formula.setTemplateItemsId(rti.getId());
                            formula.setAccountSetsId(entity.getId());
                            if (item.getInteger("sources") == 1) {
                                formula.setFromTag(objectMap.get(Integer.parseInt(formula.getFromTag())).getString("pid"));
                            } else {
                                boolean hasCode = formulas.getJSONObject(j).containsKey("subjectCode");

                                LambdaQueryWrapper<Subject> qw = Wrappers.lambdaQuery();
                                qw.eq(Subject::getAccountSetsId, entity.getId());
                                if (hasCode) {
                                    qw.eq(Subject::getCode, formulas.getJSONObject(j).getString("subjectCode"));
                                } else {
                                    Subject subject = subjectMapper.selectById(Integer.parseInt(formula.getFromTag()));
                                    qw.eq(Subject::getCode, subject.getCode());
                                }
                                qw.select(Subject::getId, Subject::getCode);
                                Subject one = subjectMapper.selectOne(qw);

                                formula.setFromTag(one.getId().toString());
                                if (!hasCode) {
                                    formulas.getJSONObject(j).put("subjectCode", one.getCode());
                                }
                            }

                            reportTemplateItemsFormulaMapper.insert(formula);
                        }
                    }
                }
            }
            log.info("最终输出{}:{}", fileName, lrb.toJSONString());
        }
    }


    private void updateVoucherDetailCode(Integer accountSetsId, Map<String, String> codeMap) {
        LambdaQueryWrapper<VoucherDetails> dqw = Wrappers.lambdaQuery();
        dqw.eq(VoucherDetails::getAccountSetsId, accountSetsId);
        List<VoucherDetails> dList = voucherDetailsService.list(dqw);
        dList.forEach(d -> {
            String name = StringUtils.trim(d.getSubjectName());
            String scode = StringUtils.trim(d.getSubjectCode());

            //获取code部分
            String[] codeSp = name.split("-", 2);
            String code = codeSp[0];
            if (code.contains("_")) {
                String[] codeAc = code.split("_", 2);
                code = (codeMap.containsKey(codeAc[0]) ? codeMap.get(codeAc[0]) : codeAc[0]) + "_" + codeAc[1];
            } else if (codeMap.containsKey(code)) {
                code = codeMap.get(code);
            }

            d.setSubjectName(code + "-" + codeSp[1]);

            if (scode.contains("_")) {
                String[] codeAc = code.split("_", 2);
                scode = (codeMap.containsKey(codeAc[0]) ? codeMap.get(codeAc[0]) : codeAc[0]) + "_" + codeAc[1];
            } else if (codeMap.containsKey(scode)) {
                scode = codeMap.get(scode);
            }
            d.setSubjectCode(scode);
        });
        if (!dList.isEmpty()) {
            voucherDetailsService.updateBatchById(dList);
        }
    }

    private void updateVoucherTempDetailCode(Integer accountSetsId, Map<String, String> codeMap) {
        LambdaQueryWrapper<VoucherTemplateDetails> dqw = Wrappers.lambdaQuery();
        dqw.eq(VoucherTemplateDetails::getAccountSetsId, accountSetsId);
        List<VoucherTemplateDetails> dList = voucherTemplateDetailsService.list(dqw);
        dList.forEach(d -> {
            String name = StringUtils.trim(d.getSubjectName());
            String scode = StringUtils.trim(d.getSubjectCode());

            //获取code部分
            String[] codeSp = name.split("-", 2);
            String code = codeSp[0];
            if (code.contains("_")) {
                String[] codeAc = code.split("_", 2);
                code = (codeMap.containsKey(codeAc[0]) ? codeMap.get(codeAc[0]) : codeAc[0]) + "_" + codeAc[1];
            } else if (codeMap.containsKey(code)) {
                code = codeMap.get(code);
            }
            d.setSubjectName(code + "-" + codeSp[1]);

            if (scode.contains("_")) {
                String[] codeAc = code.split("_", 2);
                scode = (codeMap.containsKey(codeAc[0]) ? codeMap.get(codeAc[0]) : codeAc[0]) + "_" + codeAc[1];
            } else if (codeMap.containsKey(scode)) {
                scode = codeMap.get(scode);
            }
            d.setSubjectCode(scode);
        });
        if (!dList.isEmpty()) {
            voucherTemplateDetailsService.updateBatchById(dList);
        }
    }

    private String updateCode(String code, List<Integer> model, List<Integer> newModel) {
        List<String> codeSp = new ArrayList<>();
        int start = 0;
        for (Integer len : model) {
            if (code.length() <= start) {
                break;
            }
            codeSp.add(code.substring(start, Math.min(code.length(), start + len)));
            start += len;
        }

        for (int i = 0; i < codeSp.size(); i++) {
            String item = codeSp.get(i);
            int len = newModel.get(i);
            if (item != null) {
                if (item.length() < len) {
                    item = StringUtils.leftPad(Integer.parseInt(item) + "", newModel.get(i), "0");
                } else if (item.length() > len) {
                    item = item.substring(item.length() - len);
                }
                codeSp.set(i, item);
            }
        }

        return StringUtils.join(codeSp, "");
    }
}




