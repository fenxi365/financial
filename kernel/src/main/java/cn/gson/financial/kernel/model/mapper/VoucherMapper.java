package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.Voucher;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.*;

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
public interface VoucherMapper extends BaseMapper<Voucher> {
    int batchInsert(@Param("list") List<Voucher> list);

    Integer selectMaxCode(@Param("accountSetsId") Integer accountSetsId, @Param("word") String word, @Param("year") int year, @Param("month") int month, @Param("orgId") Integer orgId);

    List<Voucher> selectVoucher(@Param(Constants.WRAPPER) Wrapper wrapper);

    IPage<Voucher> selectVoucher(IPage<Voucher> page, @Param(Constants.WRAPPER) Wrapper wrapper);

    List<VoucherDetailVo> selectAccountBookDetails(@Param("accountSetsId") Integer accountSetsId, @Param("subjectIds") List<Integer> subjectIds, @Param("accountDate") Date accountDate, @Param("orgId") Integer orgId);

    List<VoucherDetailVo> selectAccountBookStatistical(@Param("accountSetsId") Integer accountSetsId, @Param("subjectId") Integer subjectId, @Param("subjectIds") List<Integer> subjectIds, @Param("accountDate") Date accountDate, @Param("orgId") Integer orgId);

    List<VoucherDetailVo> selectAccountBookInitialBalance(@Param("accountSetsId") Integer accountSetsId, @Param("subjectIds") List<Integer> subjectIds, @Param("accountDate") Date accountDate, @Param("orgId") Integer orgId);

    List<Map<String, Object>> selectBrokenData(@Param("accountSetsId") Integer accountSetsId, @Param("year") Integer year, @Param("month") Integer month, @Param("orgId") Integer orgId);

    List<VoucherDetailVo> selectReportStatistical(@Param("accountSetsId") Integer accountSetsId, @Param("codes") Collection<String> codes, @Param("accountDate") Date accountDate, @Param("orgId") Integer orgId);

    List<Map<String, Object>> selectHomeReport(@Param("accountSetsId") Integer accountSetsId, @Param("voucherYear") Integer year, @Param("orgId") Integer orgId);

    List<Map<String, Object>> selectHomeCostReport(@Param("accountSetsId") Integer accountSetsId, @Param("voucherYear") Integer year, @Param("voucherMonth") Integer month, @Param("orgId") Integer orgId);

    List<Map<String, Object>> selectHomeCashReport(@Param("accountSetsId") Integer accountSetsId, @Param("voucherYear") Integer year, @Param("voucherMonth") Integer month, @Param("orgId") Integer orgId);

    Integer selectBeforeId(@Param("accountSetsId") Integer accountSetsId, @Param("currentId") Integer currentId, @Param("orgId") Integer orgId);

    Integer selectNextId(@Param("accountSetsId") Integer accountSetsId, @Param("currentId") Integer currentId, @Param("orgId") Integer orgId);

    List<VoucherDetailVo> selectSubjectDetail(@Param("subjectIds") Set<Integer> subjectIds, @Param("accountSetsId") Integer accountSetsId, @Param("monthBegin") Date monthBegin, @Param("monthEnd") Date monthEnd, @Param("showNumPrice") boolean showNumPrice);

    Integer updateAudit(@Param(Constants.WRAPPER) Wrapper wrapper);

    List<VoucherDetailVo> selectReportBalanceStatistical(@Param("accountSetsId") Integer accountSetsId, @Param("codes") List<String> codes, @Param("accountDate") Date accountDate, @Param("orgId") Integer orgId);

    List<VoucherDetailVo> selectReportInitBalance(@Param("accountSetsId") Integer accountSetsId, @Param("codes") List<String> codes, @Param("orgId") Integer orgId);

    Date selectMaxVoucherDate(@Param("accountSetsId") Integer accountSetsId, @Param("orgId") Integer orgId);

    List<VoucherDetailVo> selectYearReportStatistical(@Param("accountSetsId") Integer accountSetsId, @Param("codes") Collection<String> codes, @Param("year") String year, @Param("orgId") Integer orgId);

    List<Voucher> exportVoucher(@Param(Constants.WRAPPER) Wrapper wrapper);
}