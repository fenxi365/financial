package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.Currency;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CurrencyMapper extends BaseMapper<Currency> {
    int batchInsert(@Param("list") List<Currency> list);
}