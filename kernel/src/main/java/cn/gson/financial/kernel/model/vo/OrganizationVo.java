package cn.gson.financial.kernel.model.vo;

import cn.gson.financial.kernel.model.entity.Organization;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.model.vo</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月12日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class OrganizationVo extends Organization {


    private String parentCode;

    private List<OrganizationVo> children = new ArrayList<>();

}
