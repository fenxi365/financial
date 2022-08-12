/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 凭证</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年08月01日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
import Ajax from '../js/common/ajax';
import Qs from "qs";

export default {
	list(params) {
		return Ajax.get("/voucher", params)
	},
	load(id) {
		return Ajax.get(`/voucher/${id}`)
	},
	loadCode(params) {
		return Ajax.get(`/voucher/code`, params)
	},
	summary() {
		return Ajax.get(`/voucher/summary`)
	},
	delete(id) {
		return Ajax.delete(`/voucher/${id}`)
	},
	save(params = {}) {
		return Ajax.post(`/voucher`, params)
	},
	update(params = {}) {
		return Ajax.put(`/voucher`, params)
	},
	carryForwardMoney(params = {}) {
		return Ajax.post(`/voucher/carryForwardMoney`, Qs.stringify(params, {indices: false}))
	},
	finishingOffNo(params = {}) {
		return Ajax.get(`/voucher/finishingOffNo`, params)
	},
	beforeId(params = {}) {
		return Ajax.get(`/voucher/beforeId`, params)
	},
	nextId(params = {}) {
		return Ajax.get(`/voucher/nextId`, params)
	},
	batchDelete(params = {}) {
		return Ajax.post(`/voucher/batchDelete`, Qs.stringify(params, {indices: false}))
	},
	audit(params = {}) {
		return Ajax.post(`/voucher/audit`, Qs.stringify(params, {indices: false}))
	},
	cancelAudit(params = {}) {
		return Ajax.post(`/voucher/cancelAudit`, Qs.stringify(params, {indices: false}))
	},
	import(params) {
		return Ajax.post(`/voucher/import`, params, {'Content-Type': 'multipart/form-data'})
	}
}
