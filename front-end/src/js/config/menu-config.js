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
				title: '凭证列表',
				key: 'Voucher'
			}
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
		key: 'ReportList',
		icon: 'h-icon-search'
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
			}/*, {
				title: '凭证模板',
				key: 'TemplateManager'
			}*/, {
				title: '权限设置',
				key: 'PermissionSetting'
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
				title: '凭证列表',
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
		key: 'ReportList',
		icon: 'icon-bar-graph-2'
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
				title: '凭证列表',
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
		key: 'ReportList',
		icon: 'icon-bar-graph-2'
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
