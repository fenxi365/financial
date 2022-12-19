package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.vo.BalanceVo;
import cn.gson.financial.kernel.model.vo.UserVo;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Date;
import java.util.List;
import java.util.Map;

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
public interface VoucherService extends IService<Voucher> {

    int batchInsert(List<Voucher> list);

    int loadCode(Integer accountSetsId, String word, Date currentAccountDate);

    List accountBookDetails(Integer accountSetsId, Integer subjectId, Date accountDate, String subjectCode, Boolean showNumPrice);

    /**
     * 总账
     *
     * @param accountSetsId
     * @param accountDate
     * @param showNumPrice
     * @return
     */
    List accountGeneralLedger(Integer accountSetsId, Date accountDate, Boolean showNumPrice);

    /**
     * 获取期间结转科目总和
     *
     * @param accountSetsId
     * @param years
     * @param month
     * @param code
     * @return
     */
    Map<String, VoucherDetails> carryForwardMoney(Integer accountSetsId, Integer years, Integer month, String[] code);

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
    List<VoucherDetailVo> auxiliaryDetails(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Integer auxiliaryItemId, Boolean showNumPrice);

    /**
     * 本期核算项目
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @return
     */
    List<AccountingCategoryDetails> auxiliaryList(Integer accountSetsId, Integer auxiliaryId);

    /**
     * 辅助核算项目余额
     *
     * @param accountSetsId
     * @param auxiliaryId
     * @param accountDate
     * @param showNumPrice
     * @return
     */
    List<BalanceVo> auxiliaryBalance(Integer accountSetsId, Integer auxiliaryId, Date accountDate, Boolean showNumPrice);

    /**
     * 首页收入利润图表数据
     *
     * @param accountSetsId
     * @param year
     * @return
     */
    List<Map<String, Object>> getHomeReport(Integer accountSetsId, Integer year);

    /**
     * 首页费用数据
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    List<Map<String, Object>> getCostReport(Integer accountSetsId, int year, int month);

    /**
     * 首页现金数据
     *
     * @param accountSetsId
     * @param year
     * @param month
     * @return
     */
    List<Map<String, Object>> getCashReport(Integer accountSetsId, int year, int month);

    /**
     * 断号整理
     *
     * @param accountSetsId
     * @param year
     * @param month
     */
    void finishingOffNo(Integer accountSetsId, Integer year, Integer month);

    /**
     * 批量删除
     *
     * @param accountSetsId
     * @param checked
     */
    void batchDelete(Integer accountSetsId, Integer[] checked, Integer year, Integer month);

    /**
     * 根据当前 Id 获取上一条 ID
     *
     * @param accountSetsId
     * @param currentId
     * @return
     */
    Integer getBeforeId(Integer accountSetsId, Integer currentId);

    /**
     * 根据当前 Id 获取下一条 ID
     *
     * @param accountSetsId
     * @param currentId
     * @return
     */
    Integer getNextId(Integer accountSetsId, Integer currentId);

    /**
     * 获取最近使用的摘要
     *
     * @param accountSetsId
     * @return
     */
    List<String> getTopSummary(Integer accountSetsId);

    /**
     * 审核
     *
     * @param accountSetsId
     * @param checked
     */
    void audit(Integer accountSetsId, Integer[] checked, UserVo currentUser, Integer year, Integer month);

    /**
     * 反审核
     *
     * @param accountSetsId
     * @param checked
     */
    void cancelAudit(Integer accountSetsId, Integer[] checked, UserVo currentUser, Integer year, Integer month);

    /**
     * 批量导入凭证
     *
     * @param voucherList
     * @return
     */
    Date importVoucher(List<Voucher> voucherList, AccountSets accountSets);
}





