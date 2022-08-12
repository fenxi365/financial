package cn.gson.financial.kernel.service;

import cn.gson.financial.kernel.model.entity.VoucherTemplate;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.IService;
    /**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : ${PACKAGE_NAME}</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月03日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface VoucherTemplateService extends IService<VoucherTemplate>{


    int batchInsert(List<VoucherTemplate> list);

}
