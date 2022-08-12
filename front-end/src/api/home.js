/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : </li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年09月10日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import Ajax from '../js/common/ajax';

export default {
	voucherCount() {
		return Ajax.get("/home/voucher/count")
	},
	chart: {
		revenueProfit() {
			return Ajax.get("/home/chart/revenueProfit")
		},
		cost() {
			return Ajax.get("/home/chart/cost")
		},
		cash() {
			return Ajax.get("/home/chart/cash")
		}
	}
}