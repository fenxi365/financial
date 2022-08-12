package cn.gson.financial.kernel.model.vo;

import cn.gson.financial.kernel.model.entity.Subject;
import com.alibaba.fastjson.annotation.JSONField;
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
public class SubjectVo extends Subject {

    private String subjectFullName;

    private String parentCode;

    private Boolean isLeaf;

    @JSONField(name = "subjectFullName")
    public String getSubjectFullName() {
        return this.getCode() + "-" + this.getName();
    }

    private List<SubjectVo> children = new ArrayList<>();

}
