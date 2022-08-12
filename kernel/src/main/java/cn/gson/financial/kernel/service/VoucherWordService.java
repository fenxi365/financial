package cn.gson.financial.kernel.service;

import java.util.List;
import cn.gson.financial.kernel.model.entity.VoucherWord;
import com.baomidou.mybatisplus.extension.service.IService;

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
public interface VoucherWordService extends IService<VoucherWord> {


    int batchInsert(List<VoucherWord> list);

}

