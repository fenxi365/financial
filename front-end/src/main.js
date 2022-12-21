import Vue from 'vue';
import App from './views/App.vue';
import Login from './views/Login.vue';
import router from './router';
import store from './store';
import api from './api';
import AppContent from './components/AppContent';
import AccountDateChoose from './components/AccountDateChoose';
import SubMenu from './components/common/sub-menu';
import Chart from './views/app/chart/echarts';

import './js/config/dict';
import './js/common/filters';

if (process.env.NODE_ENV !== 'development') {
	require('./reporter');
}

require('font-awesome/css/font-awesome.css');
require('./styles/app.less');

Vue.use(HeyUI);
Vue.prototype.$api = api;

Vue.component("app-content", AppContent);
Vue.component("account-date-choose", AccountDateChoose);
Vue.component('sub-menu', SubMenu);
Vue.component('Chart', Chart);

Vue.config.productionTip = false;

const VueConfig = {
	router,
	store,
};

store.dispatch("init").then(() => {
	//实例化界面
	new Vue(Object.assign(VueConfig, {
		render: h => h(App)
	})).$mount('#app');
}).catch(() => {
	new Vue(Object.assign(VueConfig, {
		render: h => h(Login)
	})).$mount('#app');
});
