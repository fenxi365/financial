import Vue from 'vue'
import Vuex from 'vuex'
import Common from './api/common'

Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		User: {
			name: '夏悸',
			desc: '执着于理想，纯粹于当下',
			email: 'HeyUI@some.com',
			org: '某某公司',
			dept: '某某部门',
			title: '前端开发工程师',
			location: '上海市',
			avatar: '/images/avatar.png',
			tags: ['善解人意', '耿直']
		},
		currentAccountSets: {},
		myAccountSets: [],
		sliderCollapsed: false
	},
	mutations: {
		updateAccount(state, data) {
			state.User = data;
			state.currentAccountSets = data.accountSets;
			state.myAccountSets = data.accountSetsList;
		},
		updateSliderCollapse(state, isShow) {
			setTimeout(() => {
				G.trigger('page_resize');
			}, 600);
			state.sliderCollapsed = isShow;
		}
	},
	actions: {
		init(context) {
			return new Promise((resolve, reject) => {
				Common.init().then(({data}) => {
					context.commit('updateAccount', data);
					resolve(data)
				}).catch(() => {
					reject();
				})
			});
		}
	},
	getters: {
		account: state => {
			return state.User;
		},
		sliderCollapsed: state => {
			return state.sliderCollapsed;
		}
	}
})
