package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.VoucherDetails;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.mapper</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年10月21日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Mapper
public interface VoucherDetailsMapper extends BaseMapper<VoucherDetails> {
    int batchInsert(@Param("list") List<VoucherDetails> list);

    VoucherDetails selectCarryForwardMoney(@Param("accountSetsId") Integer accountSetsId, @Param("years") Integer years, @Param("month") Integer month, @Param("code") String code, @Param("orgId") Integer orgId);

    VoucherDetails selectFinalCheckData(@Param("accountSetsId") Integer accountSetsId, @Param("year") Integer year, @Param("month") Integer month, @Param("orgId") Integer orgId);

    /**
     * 报表检查 资产-负债=权益
     *
     * @param accountSetsId
     * @param voucherDate
     * @return
     */
    List<VoucherDetails> assetStatistics(@Param("accountSetsId") Integer accountSetsId, @Param("voucherDate") Date voucherDate, @Param("orgId") Integer orgId);

    /**
     * 最常用备注
     *
     * @param accountSetsId
     * @return
     */
    List<String> selectTopSummary(@Param("accountSetsId") Integer accountSetsId, @Param("orgId") Integer orgId);

    /**
     * 科目余额计算汇总数据
     *
     * @param accountSetsId
     * @param subjectId
     * @param categoryId
     * @param categoryDetailsId
     * @return
     */
    List<VoucherDetailVo> selectBalanceData(@Param("accountSetsId") Integer accountSetsId, @Param("subjectId") Integer subjectId, @Param("categoryId") Integer categoryId, @Param("categoryDetailsId") Integer categoryDetailsId, @Param("orgId") Integer orgId);

    /**
     * 期初检查
     *
     * @param accountSetsId
     * @return
     */
    Map<String, Double> selectListInitialCheckData(@Param("accountSetsId") Integer accountSetsId, @Param("orgId") Integer orgId);

    List<VoucherDetails> selectBalanceList(@Param("accountSetsId") Integer accountSetsId, @Param("type") String type, @Param("orgId") Integer orgId);

    List<Map> selectBassetsAndLiabilities(@Param("accountSetsId") Integer accountSetsId, @Param("orgId") Integer orgId);

    List<VoucherDetails> selectAuxiliaryList(@Param("accountSetsId") Integer accountSetsId, @Param("type") String type, @Param("orgId") Integer orgId);

    List<VoucherDetails> selectAggregateAmount(@Param("accountSetsId") Integer accountSetsId, @Param("codeList") Set<String> codeList, @Param("year") int year, @Param("month") int month);
}