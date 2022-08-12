/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : </li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月15日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import wpkReporter from 'wpk-reporter'; // 导入基础sdk
const __wpk = new wpkReporter({
	bid: 'rok2nfw7-qkyd2ulc', // 新建应用时确定
	spa: true,  // 单页应用开启后，可更准确地采集PV
	plugins: []
});

__wpk.installAll(); // 初始化sdk 必须调用
