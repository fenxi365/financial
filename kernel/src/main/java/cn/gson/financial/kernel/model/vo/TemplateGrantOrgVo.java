package cn.gson.financial.kernel.model.vo;

import cn.gson.financial.kernel.model.entity.ReportTemplate;
import lombok.Data;

import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/9 15:24</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
public class TemplateGrantOrgVo {

    private ReportTemplate template;

    private List<Integer> orgIds;
}
