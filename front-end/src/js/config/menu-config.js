const Manager = [
	{
		title: '主页',
		key: 'Home',
		icon: 'h-icon-home'
	},
	{
		title: '凭证',
		key: 'vouchers',
		icon: 'h-icon-star',
		children: [
			{
				title: '新增凭证',
				key: 'VoucherForm'
			},
			{
				title: '凭证查询',
				key: 'Voucher'
			}
			// ,{
			// 	title: '进销存凭证',
			// 	key: 'JxcVoucher'
			// }
		]
	},
	{
		title: '结账',
		key: 'CheckList',
		icon: 'h-icon-complete',
	},
	{
		title: '帐薄',
		key: 'AccountBooks',
		icon: 'h-icon-task',
		children: [
			{
				title: '明细账',
				key: 'DetailedAccounts'
			},
			{
				title: '总账',
				key: 'GeneralLedger'
			},
			{
				title: '科目余额',
				key: 'SubjectBalance'
			},
			{
				title: '科目汇总',
				key: 'SubjectSummary'
			},
			{
				title: '核算项目明细账',
				key: 'AuxiliaryAccountingDetail'
			},
			{
				title: '核算项目余额',
				key: 'AuxiliaryAccountingBalance'
			}
		]
	},
	{
		title: '报表',
		key: 'report',
		icon: 'h-icon-search',
		children: [
			{
				title: '报表模版',
				key: 'ReportTemplate'
			},
			{
				title: '利润表',
				key: 'ProfitStatement'
			},
			{
				title: '资产负债表',
				key: 'BalanceStatement'
			},
			{
				title: '现金流量表',
				key: 'CashFlowStatement'
			},
			{
				title: '年度利润表',
				key: 'YearProfitStatement'
			},
			{
				title: '多组织利润表',
				key: 'OrgProfitStatement'
			},
		]
	},
	{
		title: '设置',
		key: 'Setting',
		icon: 'h-icon-setting',
		children: [
			{
				title: '账套',
				key: 'Account'
			},
			{
				title: '科目',
				key: 'Subject'
			},
			{
				title: '期初',
				key: 'Initial'
			},
			{
				title: '币别',
				key: 'Currency'
			},
			{
				title: '凭证字',
				key: 'VoucherWord'
			}, {
				title: '辅助核算',
				key: 'AccountingCategory'
			 },
			//{
			// 	title: '关联进销存',
			// 	key: 'JxcSetting'
			// },
			{
				title: '权限设置',
				key: 'PermissionSetting'
			},{
				title: '组织机构',
				key: 'Organization'
			}
		]
	}
];

const Making = [
	{
		title: '主页',
		key: 'Home',
		icon: 'icon-monitor'
	},
	{
		title: '凭证',
		key: 'vouchers',
		icon: 'icon-grid-2',
		children: [
			{
				title: '新增凭证',
				key: 'VoucherForm'
			},
			{
				title: '凭证查询',
				key: 'Voucher'
			}
		]
	},
	{
		title: '结账',
		key: 'CheckList',
		icon: 'icon-disc',
	},
	{
		title: '帐薄',
		key: 'AccountBooks',
		icon: 'icon-paper',
		children: [
			{
				title: '明细账',
				key: 'DetailedAccounts'
			},
			{
				title: '总账',
				key: 'GeneralLedger'
			},
			{
				title: '科目余额',
				key: 'SubjectBalance'
			},
			{
				title: '科目汇总',
				key: 'SubjectSummary'
			},
			{
				title: '核算项目明细账',
				key: 'AuxiliaryAccountingDetail'
			},
			{
				title: '核算项目余额',
				key: 'AuxiliaryAccountingBalance'
			}
		]
	},
	{
		title: '报表',
		key: 'report',
		icon: 'icon-bar-graph-2',
		children: [
			{
				title: '报表模版',
				key: 'ReportTemplate'
			},
			{
				title: '利润表',
				key: 'ProfitStatement'
			},
			{
				title: '资产负债表',
				key: 'BalanceStatement'
			},
			{
				title: '现金流量表',
				key: 'CashFlowStatement'
			},
			{
				title: '年度利润表',
				key: 'YearProfitStatement'
			},
			{
				title: '多组织利润表',
				key: 'OrgProfitStatement'
			},
		]
	},
	{
		title: '设置',
		key: 'Setting',
		icon: 'icon-cog',
		children: [
			{
				title: '账套',
				key: 'Account'
			}
		]
	}
];

const View = [
	{
		title: '主页',
		key: 'Home',
		icon: 'icon-monitor'
	},
	{
		title: '凭证',
		key: 'vouchers',
		icon: 'icon-grid-2',
		children: [
			{
				title: '凭证查询',
				key: 'Voucher'
			}
		]
	},
	{
		title: '帐薄',
		key: 'AccountBooks',
		icon: 'icon-paper',
		children: [
			{
				title: '明细账',
				key: 'DetailedAccounts'
			},
			{
				title: '总账',
				key: 'GeneralLedger'
			},
			{
				title: '科目余额',
				key: 'SubjectBalance'
			},
			{
				title: '科目汇总',
				key: 'SubjectSummary'
			},
			{
				title: '核算项目明细账',
				key: 'AuxiliaryAccountingDetail'
			},
			{
				title: '核算项目余额',
				key: 'AuxiliaryAccountingBalance'
			}
		]
	},
	{
		title: '报表',
		key: 'report',
		icon: 'icon-bar-graph-2',
		children: [
			{
				title: '报表模版',
				key: 'ReportTemplate'
			},
			{
				title: '利润表',
				key: 'ProfitStatement'
			},
			{
				title: '资产负债表',
				key: 'BalanceStatement'
			},
			{
				title: '现金流量表',
				key: 'CashFlowStatement'
			},
			{
				title: '年度利润表',
				key: 'YearProfitStatement'
			},
			{
				title: '多组织利润表',
				key: 'OrgProfitStatement'
			},
		]
	},
	{
		title: '设置',
		key: 'Setting',
		icon: 'icon-cog',
		children: [
			{
				title: '账套',
				key: 'Account'
			}
		]
	}
];

export default {
	Manager,
	Making,
	View
};
