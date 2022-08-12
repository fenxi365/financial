package cn.gson.financial.kernel.model.mapper;

import cn.gson.financial.kernel.model.entity.AccountingCategoryDetails;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

@Mapper
public interface AccountingCategoryDetailsMapper extends BaseMapper<AccountingCategoryDetails> {
    int batchInsert(@Param("list") List<AccountingCategoryDetails> list);

    List<AccountingCategoryDetails> selectByCodeSet(@Param("name") String name, @Param("accountSetsId") Integer accountSetsId, @Param("codeSet") Set<String> value);
}