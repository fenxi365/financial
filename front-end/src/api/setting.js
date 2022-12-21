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
	//账套管理
	accountSets: {
		list() {
			return Ajax.get("/account-sets")
		},
		load(id) {
			return Ajax.get(`/account-sets/${id}`)
		},
		delete(id, smsCode) {
			return Ajax.delete(`/account-sets/${id}/${smsCode}`)
		},
		save(params = {}) {
			return Ajax.post(`/account-sets`, params)
		},
		addUser(params = {}) {
			return Ajax.get(`/account-sets/addUser`, params)
		},
		updateUserRole(params = {}) {
			return Ajax.get(`/account-sets/updateUserRole`, params)
		},
		addNewUser(params = {}) {
			return Ajax.get(`/account-sets/addNewUser`, params)
		},
		removeUser(uid) {
			return Ajax.get(`/account-sets/removeUser/${uid}`)
		},
		checkUse(asid) {
			return Ajax.get(`/account-sets/checkUse`, {asid})
		},
		update(params = {}) {
			return Ajax.put(`/account-sets`, params)
		},
		identification(params = {}) {
			return Ajax.post(`/account-sets/identification`, Qs.stringify(params))
		},
		handOver(params = {}) {
			return Ajax.post(`/account-sets/handOver`, Qs.stringify(params))
		},
		updateEncode(params = {}) {
			return Ajax.post(`/account-sets/updateEncode`, Qs.stringify(params))
		}
	},
	//凭证字
	voucherWord: {
		list() {
			return Ajax.get("/voucher-word")
		},
		load(id) {
			return Ajax.get(`/voucher-word/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/voucher-word/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/voucher-word`, params)
		},
		update(params = {}) {
			return Ajax.put(`/voucher-word`, params)
		}
	},
	//币别
	currency: {
		list() {
			return Ajax.get("/currency")
		},
		load(id) {
			return Ajax.get(`/currency/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/currency/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/currency`, params)
		},
		update(params = {}) {
			return Ajax.put(`/currency`, params)
		}
	},
	//科目
	subject: {
		list(type) {
			return Ajax.get("/subject?type=" + type)
		},
		load(id) {
			return Ajax.get(`/subject/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/subject/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/subject`, params)
		},
		update(params = {}) {
			return Ajax.put(`/subject`, params)
		},
		voucherSelect(params = {}) {
			return Ajax.get(`/subject/voucher/select`, params)
		},
		loadByCode(code = [], checkData = {}) {
			return Ajax.post(`/subject/loadByCode`, Qs.stringify(Object.assign(checkData, {code: code.filter(v => !!v)}), {indices: false}))
		},
		checkUse(id) {
			return Ajax.get(`/subject/checkUse/${id}`)
		},
		balance(params = {}) {
			return Ajax.get(`/subject/balance`, params)
		},
		import(params) {
			return Ajax.post(`/subject/import`, params, {'Content-Type': 'multipart/form-data'})
		}
	},
	//科目
	initialBalance: {
		list(type) {
			return Ajax.get("/initial-balance?type=" + type)
		},
		load(id) {
			return Ajax.get(`/initial-balance/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/initial-balance/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/initial-balance`, params)
		},
		update(params = {}) {
			return Ajax.put(`/initial-balance`, params)
		},
		trialBalance() {
			return Ajax.get(`/initial-balance/trialBalance`)
		},
		saveAuxiliary(params) {
			return Ajax.post(`/initial-balance/auxiliary`, params)
		}
	},
	//辅助核算类别
	accountingCategory: {
		list() {
			return Ajax.get("/accounting-category")
		},
		load(id) {
			return Ajax.get(`/accounting-category/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/accounting-category/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/accounting-category`, params)
		},
		update(params = {}) {
			return Ajax.put(`/accounting-category`, params)
		},
		import(params) {
			return Ajax.post(`/accounting-category/import`, params, {'Content-Type': 'multipart/form-data'})
		}
	},
	accountingCategoryDetails: {
		list(categoryId, params = {}) {
			return Ajax.get(`/accounting-category-details?accounting_category_id=${categoryId}`, params)
		},
		load(id) {
			return Ajax.get(`/accounting-category-details/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/accounting-category-details/${id}`)
		},
		clearData(id) {
			return Ajax.delete(`/accounting-category-details/clear/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/accounting-category-details`, params)
		},
		update(params = {}) {
			return Ajax.put(`/accounting-category-details`, params)
		},
		loadAuxiliaryAccountingData(params) {
			return Ajax.post(`/accounting-category-details/loadAuxiliaryAccountingData`, params)
		}
	},
	//用户
	user: {
		list() {
			return Ajax.get("/user")
		},
		load(id) {
			return Ajax.get(`/user/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/user/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/user`, params)
		},
		update(params = {}) {
			return Ajax.put(`/user`, params)
		}
	},
	//模板
	voucherTemplate: {
		list() {
			return Ajax.get("/voucher-template")
		},
		load(id) {
			return Ajax.get(`/voucher-template/${id}`)
		},
		delete(id) {
			return Ajax.delete(`/voucher-template/${id}`)
		},
		save(params = {}) {
			return Ajax.post(`/voucher-template`, params)
		},
		update(params = {}) {
			return Ajax.put(`/voucher-template`, params)
		}
	}
}
