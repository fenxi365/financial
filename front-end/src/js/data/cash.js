export default {
	tooltip: {
		trigger: 'item',
		formatter: "{b} : <br>{c}K ({d}%)"
	},
	legend: {
		data: ['库存现金', '银行存款', '其他货币资金'],
		selected: ['库存现金', '银行存款', '其他货币资金']
	},
	series: [
		{
			name: '费用',
			type: 'pie',
			radius: '50%',
			data: [{name: '库存现金', value: 0}, {name: '银行存款', value: 0}, {name: '其他货币资金', value: 0}],
			itemStyle: {
				emphasis: {
					shadowBlur: 10,
					shadowOffsetX: 0,
					shadowColor: 'rgba(0, 0, 0, 0.5)'
				}
			}
		}
	]
};