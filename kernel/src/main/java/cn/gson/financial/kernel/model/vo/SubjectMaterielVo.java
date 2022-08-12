package cn.gson.financial.kernel.model.vo;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/17 15:06</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SubjectMaterielVo  implements Serializable {

    private Integer subjectId;

    /**
     * 科目类型
     */
    private Object type;

    /**
     * 科目编码
     */
    private String code;

    /**
     * 科目名称
     */
    private String name;


    private Integer materielId;

    @JSONField(name = "subjectFullName")
    public String getSubjectFullName() {
        return this.getCode() + "-" + this.getName();
    }
}
