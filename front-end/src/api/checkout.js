/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : </li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月25日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import Ajax from '../js/common/ajax';

export default {
	list(params) {
		return Ajax.get("/checkout",params)
	},
	initialCheck(params) {
		return Ajax.get("/checkout/initialCheck", params)
	},
	finalCheck(params) {
		return Ajax.get("/checkout/finalCheck", params)
	},
	reportCheck(params) {
		return Ajax.get("/checkout/reportCheck", params)
	},
	brokenCheck(params) {
		return Ajax.get("/checkout/brokenCheck", params)
	},
	invoicing(params) {
		return Ajax.get("/checkout/invoicing", params)
	},
	unCheck(params) {
		return Ajax.get("/checkout/unCheck", params)
	}
}