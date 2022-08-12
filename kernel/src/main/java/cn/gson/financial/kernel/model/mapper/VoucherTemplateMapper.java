package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.VoucherTemplate;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface VoucherTemplateMapper extends BaseMapper<VoucherTemplate> {
    int batchInsert(@Param("list") List<VoucherTemplate> list);

    List<VoucherTemplate> selectVoucherTemplate(@Param(Constants.WRAPPER) Wrapper wrapper);
}