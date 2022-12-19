package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.AccountSets;
import cn.gson.financial.kernel.model.entity.Subject;
import cn.gson.financial.kernel.model.vo.BalanceVo;
import cn.gson.financial.kernel.model.vo.SubjectVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Date;
import java.util.List;

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
public interface SubjectService extends IService<Subject> {

    int batchInsert(List<Subject> list);

    List<SubjectVo> selectData(Wrapper<Subject> queryWrapper, boolean showAll);

    /**
     * 凭证明细的科目菜单
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    List<Subject> accountBookList(Date accountDate, Integer accountSetsId, boolean showNumPrice);

    /**
     * 科目余额
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    List<BalanceVo> subjectBalance(Date accountDate, Integer accountSetsId, boolean showNumPrice);

    /**
     * 科目汇总
     *
     * @param accountDate
     * @param accountSetsId
     * @return
     */
    List subjectSummary(Date accountDate, Integer accountSetsId, boolean showNumPrice);

    /**
     * vo
     *
     * @param queryWrapper
     * @return
     */
    List<SubjectVo> listVo(Wrapper<Subject> queryWrapper);

    /**
     * 检查科目是否已经被使用
     *
     * @param id
     * @return
     */
    Boolean checkUse(Integer id);

    /**
     * 科目余额
     *
     * @param accountSetsId
     * @param subjectId
     * @param categoryId
     * @param categoryDetailsId
     * @return
     */
    Double balance(Integer accountSetsId, Integer subjectId, Integer categoryId, Integer categoryDetailsId);

    /**
     * 过滤出所有没有子节点的科目
     *
     * @param accountSetsId
     * @return
     */
    List<Integer> leafList(Integer accountSetsId);

    List<Subject> balanceSubjectList(Date accountDate, Integer accountSetsId, boolean b);

    void importVoucher(List<SubjectVo> voucherList, AccountSets accountSets);
}





