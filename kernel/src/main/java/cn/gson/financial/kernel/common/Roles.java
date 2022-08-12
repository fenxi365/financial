package cn.gson.financial.kernel.common;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.common</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月27日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public enum Roles {
    Manager("账套管理员"),
    Director("主管"),
    Making("制单人"),
    Cashier("出纳"),
    View("查看");

    public String display;

    Roles(String display) {
        this.display = display;
    }
}
