package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import cn.gson.financial.kernel.model.entity.VoucherDetailsAuxiliary;
import cn.gson.financial.kernel.model.vo.VoucherDetailVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.mapper</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Mapper
public interface VoucherDetailsAuxiliaryMapper extends BaseMapper<VoucherDetailsAuxiliary> {
    int batchInsert(@Param("list") List<VoucherDetailsAuxiliary> list);

    List<AccountingCategoryDetails> selectByAccountBlock(@Param("accountSetsId") Integer accountSetsId, @Param("auxiliaryId") Integer auxiliaryId);

    List<VoucherDetailVo> selectAccountBookDetails(@Param("accountSetsId") Integer accountSetsId, @Param("auxiliaryId") Integer auxiliaryId, @Param("accountDate") Date accountDate, @Param("auxiliaryItemId") Integer auxiliaryItemId);

    List<VoucherDetailVo> selectAccountBookStatistical(@Param("accountSetsId") Integer accountSetsId, @Param("auxiliaryId") Integer auxiliaryId, @Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("auxiliaryItemId") Integer auxiliaryItemId);

}