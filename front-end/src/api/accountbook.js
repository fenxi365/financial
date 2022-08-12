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
	loadSubject(params = {}) {
		return Ajax.get("/accountBook/list", params)
	},
	loadVoucherDetails(params = {}) {
		return Ajax.get("/accountBook/details", params)
	},
	loadGeneralLedger(params = {}) {
		return Ajax.get("/accountBook/generalLedger", params)
	},
	loadSubjectBalance(params = {}) {
		return Ajax.get("/accountBook/subjectBalance", params)
	},
	loadSubjectSummary(params = {}) {
		return Ajax.get("/accountBook/subjectSummary", params)
	},
	loadAuxiliaryDetails(params = {}) {
		return Ajax.get("/accountBook/auxiliaryDetails", params)
	},
	loadAuxiliaryList(params = {}) {
		return Ajax.get("/accountBook/auxiliaryList", params)
	},
	loadAuxiliaryBalance(params = {}) {
		return Ajax.get("/accountBook/auxiliaryBalance", params)
	}
}