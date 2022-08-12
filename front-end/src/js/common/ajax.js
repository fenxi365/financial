import axios from 'axios';
import Utils from './utils';

axios.defaults.headers.common = {
	'X-Requested-With': 'XMLHttpRequest',
};

const DefaultParam = {repeatable: false};

let ajax = {
	PREFIX: '/api',
	Author: Utils.getAuthor() || 'gson',
	requestingApi: new Set(),
	extractUrl: function (url) {
		return url ? url.split('?')[0] : '';
	},
	isRequesting: function (url) {
		let api = this.extractUrl(url);
		return this.requestingApi.has(api);
	},
	addRequest: function (url) {
		let api = this.extractUrl(url);
		this.requestingApi.add(api);
	},
	deleteRequest: function (url) {
		let api = this.extractUrl(url);
		this.requestingApi.delete(api);
	},
	get: function (url, param, extendParam) {
		let params = {
			url,
			method: 'GET'
		};
		if (param) {
			params.params = param;
		}
		return this.ajax(params, extendParam);
	},
	post: function (url, data, extendParam) {
		let params = {
			url,
			data,
			method: 'POST'
		};
		return this.ajax(params, extendParam);
	},
	put: function (url, data, extendParam) {
		let params = {
			url,
			data,
			method: 'PUT'
		};
		return this.ajax(params, extendParam);
	},
	postJson: function (url, paramJson, extendParam) {
		return this.ajax({
			url,
			method: 'POST',
			data: paramJson
		}, extendParam);
	},
	patchJson: function (url, paramJson, dataType, extendParam) {
		return this.ajax({
			url,
			method: 'PATCH',
			data: paramJson
		}, extendParam);
	},
	delete: function (url, extendParam) {
		return this.ajax({
			url: url,
			method: 'DELETE'
		}, extendParam);
	},
	ajax: function (param, extendParam) {
		let params = Utils.extend({}, DefaultParam, param, extendParam || {});
		params.crossDomain = params.url.indexOf('http') === 0;
		let url = params.url;
		if (!params.crossDomain) {
			url = params.url = this.PREFIX + params.url;
		}
		if (params.method !== 'GET') {
			if (this.isRequesting(url)) {
				return new Promise((resolve, reject) => {
					reject({success: false, msg: '重复请求'});
				});
			}
			if (params.repeatable === false) {
				this.addRequest(url);
			}
		}
		let header = {
			author: this.Author/*,
			Authorization: Utils.getLocal('token')*/
		};
		let defaultParam = {
			headers: header,
			responseType: 'json',
			validateStatus: function (status) {
				return true;
			}
		};
		if (params.crossDomain) {
			defaultParam.headers = {};
		}
		let that = this;
		params = Utils.extend({}, defaultParam, params);
		return new Promise((resolve, reject) => {
			HeyUI.$LoadingBar.start();
			return axios.request(params).then((response) => {
				that.deleteRequest(params.url);
				let data = response.data;
				let status = response.status;
				if (status !== 200) {
					if (status === 500) {
						HeyUI.$Message.error('后台异常');
						reject();
						return
					} else if (status === 404) {
						HeyUI.$Message.error('请求不存在');
						reject();
						return
					} else if (status === 403) {
						window.location.replace("/");
						return
					}
				}

				if (data.success) {
					resolve(data);
				} else {
					data.msg && HeyUI.$Message.error(data.msg);
					reject(data)
				}
			}).catch(() => {
				that.deleteRequest(params.url);
				reject({
					success: false
				});
			}).finally(() => {
				HeyUI.$LoadingBar.success();
			});
		});
	}
};
export default ajax;
