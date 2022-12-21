import Vue from 'vue';
import Router from 'vue-router';
import Home from './views/Home.vue';

Vue.use(Router);

export default new Router({
	mode: 'history',
	base: process.env.BASE_URL,
	routes: [
		{
			path: '/',
			name: 'Home',
			component: Home,
			meta: {
				title: '让每个决策都有数据支撑'
			}
		},
		{
			path: '/voucher',
			name: 'Voucher',
			component: () => import('./views/voucher/Index'),
			meta: {
				title: '凭证列表'
			}
		},
		{
			path: '/voucher/form/:voucherId(\\d+)?',
			name: 'VoucherForm',
			component: () => import('./views/voucher/VoucherForm'),
			props: true,
			meta: {
				title: '凭证信息'
			}
		},
		{
			path: '/check-out',
			name: 'CheckOut',
			component: () => import('./views/checkout/Index'),
			children: [
				{
					path: 'list',
					name: 'CheckList',
					component: () => import('./views/checkout/CheckList'),
					meta: {
						title: '结账'
					}
				},
				{
					path: 'un-check',
					name: 'UnCheckOut',
					component: () => import('./views/checkout/UnCheckOut'),
					meta: {
						title: '反结账'
					}
				}, {
					path: 'carry-forward/:checkYear(\\d+)/:checkMonth(\\d+)',
					name: 'CarryForward',
					props: true,
					component: () => import('./views/checkout/CarryForward'),
					meta: {
						title: '月末结转'
					}
				}, {
					path: 'check/:checkYear(\\d+)/:checkMonth(\\d+)',
					name: 'Check',
					props: true,
					component: () => import('./views/checkout/Check'),
					meta: {
						title: '检查'
					}
				}
			]
		},
		{
			path: '/account',
			name: 'Account',
			component: () => import('./views/setting/Account'),
			meta: {
				title: '账套'
			}
		},
		{
			path: '/subject',
			name: 'Subject',
			component: () => import('./views/setting/Subject'),
			meta: {
				title: '科目'
			}
		},
		{
			path: '/initial',
			name: 'Initial',
			component: () => import('./views/setting/Initial'),
			meta: {
				title: '期初'
			}
		},
		{
			path: '/voucher-word',
			name: 'VoucherWord',
			component: () => import('./views/setting/VoucherWord'),
			meta: {
				title: '凭证字'
			}
		},
		{
			path: '/currency',
			name: 'Currency',
			component: () => import('./views/setting/Currency'),
			meta: {
				title: '币别'
			}
		},
		{
			path: '/assisting-accounting',
			name: 'AssistingAccounting',
			component: () => import('./views/setting/AssistingAccounting'),
			meta: {
				title: '辅助核算'
			},
			children: [
				{
					path: 'accounting-category',
					name: 'AccountingCategory',
					component: () => import('./views/setting/AssistingAccounting/AccountingCategory'),
					meta: {
						title: '辅助核算类别'
					}
				},
				{
					path: 'custom/:id(\\d+)',
					name: 'CategoryCustom',
					component: () => import('./views/setting/AssistingAccounting/CategoryCustom'),
					props: true,
					meta: {
						title: '自定类别'
					}
				}
			]
		},
		{
			path: '/template',
			component: () => import('./views/setting/template/Index'),
			meta: {
				title: '模板管理'
			},
			children: [{
				path: 'manager',
				name: 'TemplateManager',
				component: () => import('./views/setting/template/TemplateManager'),
				meta: {
					title: '模板管理'
				}
			}, {
				path: 'design/:templateId(\\d+)?',
				name: 'TemplateDesign',
				component: () => import('./views/setting/template/TemplateDesign'),
				props: true,
				meta: {
					title: '模板设计'
				}
			}]
		},
		{
			path: '/permission-setting',
			name: 'PermissionSetting',
			component: () => import('./views/setting/PermissionSetting'),
			meta: {
				title: '权限设置'
			}
		},
		{
			path: '/personal',
			name: 'Personal',
			component: () => import('./views/personal/Index'),
			meta: {
				title: '个人设置'
			},
			children: [
				{
					path: 'personal-setting',
					name: 'PersonalSetting',
					component: () => import('./views/personal/PersonalSetting'),
					meta: {
						title: '个人设置'
					}
				},
				{
					path: 'change-password',
					name: 'ChangePassword',
					component: () => import('./views/personal/ChangePassword'),
					meta: {
						title: '修改密码'
					}
				},
				{
					path: 'change-phone-number',
					name: 'ChangePhoneNumber',
					component: () => import('./views/personal/ChangePhoneNumber'),
					meta: {
						title: '修改手机'
					}
				},
				{
					path: 'binding-webchat',
					name: 'BindingWebchat',
					component: () => import('./views/personal/BindingWebchat'),
					meta: {
						title: '绑定微信'
					}
				}
			]
		},
		{
			path: '/account-book/detailed',
			name: 'DetailedAccounts',
			component: () => import('./views/accountbook/DetailedAccounts'),
			meta: {
				title: '明细账'
			}
		},
		{
			path: '/account-book/general-ledger',
			name: 'GeneralLedger',
			component: () => import('./views/accountbook/GeneralLedger'),
			meta: {
				title: '总账'
			}
		},
		{
			path: '/account-book/subject-balance',
			name: 'SubjectBalance',
			component: () => import('./views/accountbook/SubjectBalance'),
			meta: {
				title: '科目余额'
			}
		},
		{
			path: '/account-book/subject-summary',
			name: 'SubjectSummary',
			component: () => import('./views/accountbook/SubjectSummary'),
			meta: {
				title: '科目汇总'
			}
		},
		{
			path: '/account-book/auxiliary-accounting-balance',
			name: 'AuxiliaryAccountingBalance',
			component: () => import('./views/accountbook/AuxiliaryAccountingBalance'),
			meta: {
				title: '辅助核算余额'
			}
		},
		{
			path: '/account-book/auxiliary-accounting-detail',
			name: 'AuxiliaryAccountingDetail',
			component: () => import('./views/accountbook/AuxiliaryAccountingDetail'),
			meta: {
				title: '辅助核算明细账'
			}
		},
		{
			path: '/report',
			name: 'ReportList',
			component: () => import('./views/report/ReportList'),
			meta: {
				title: '报表'
			}
		},
		{
			path: '/report/view/:reportId(\\d+)',
			name: 'ReportView',
			props: true,
			component: () => import('./views/report/ReportView'),
			meta: {
				title: '报表数据'
			}
		},
		{
			path: '/report/template',
			name: 'ReportTemplate',
			component: () => import('./views/report/template/TemplateList'),
			meta: {
				title: '报表模板'
			}
		},
		{
			path: '/report/template/form/:templateId(\\d+)',
			name: 'TemplateForm',
			props: true,
			component: () => import('./views/report/template/TemplateForm'),
			meta: {
				title: '模板编辑'
			}
		}
	]
});
