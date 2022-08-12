package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.VoucherWord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface VoucherWordMapper extends BaseMapper<VoucherWord> {
    int batchInsert(@Param("list") List<VoucherWord> list);
}