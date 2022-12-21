/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : </li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import Ajax from '../js/common/ajax';
import Qs from "qs";

export default {
	login(params = {}) {
		return Ajax.post('/login', Qs.stringify(params));
	},
	register(params = {}) {
		return Ajax.post('/register', Qs.stringify(params));
	},
	logout() {
		return Ajax.get('/logout');
	},
	init() {
		return Ajax.get('/init');
	},
	updateUser(params = {}) {
		return Ajax.post('/updateUser', Qs.stringify(params));
	},
	updatePwd(params = {}) {
		return Ajax.post('/updatePwd', Qs.stringify(params));
	},
	changePhoneNumber(params = {}) {
		return Ajax.post('/changePhoneNumber', Qs.stringify(params));
	},
	sendMsg(mobile) {
		return Ajax.get(`/sendMsg/${mobile}`);
	},
	regMsg(mobile) {
		return Ajax.get(`/regMsg/${mobile}`);
	},
	changeAccountSets(accountSetsId) {
		return Ajax.get(`/changeAccountSets?accountSetsId=${accountSetsId}`);
	},
	resetPassword(params = {}) {
		return Ajax.post('/resetPassword', Qs.stringify(params));
	}
}
