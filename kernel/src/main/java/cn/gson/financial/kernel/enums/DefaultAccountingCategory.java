package cn.gson.financial.kernel.enums;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2022 soho team All Rights Reserved<b></p>
 * <ul style=margin:15px;>
 * <li>Description : cn.gson.financial.kernel.enums</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022年07月29日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public enum DefaultAccountingCategory {
    客户(new String[]{"助记码", "客户类别", "经营地址", "联系人", "手机", "税号"}),
    供应商(new String[]{"助记码", "供应商类别", "经营地址", "联系人", "手机", "税号"}),
    职员(new String[]{"助记码", "性别", "部门编码", "部门名称", "职务", "岗位", "手机", "出生日期", "入职日期", "离职日期"}),
    部门(new String[]{"助记码", "负责人", "手机", "成立日期", "撤销日期"}),
    项目(new String[]{"助记码", "负责部门", "负责人", "手机", "开始日期", "验收日期"}),
    存货(new String[]{"助记码", "规格型号", "存货类别", "计量单位", "启用日期", "停用日期"}),
    现金流(new String[]{"助记码", "现金流类别"}),
    核算机构(new String[]{"助记码", "类型"});

    public final String[] fields;

    DefaultAccountingCategory(String[] fields) {
        this.fields = fields;
    }
}
