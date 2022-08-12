export default {
	tooltip: {
		trigger: 'item',
		formatter: "{b} : <br>{c}K ({d}%)"
	},
	legend: {
		data: ['销售费用', '管理费用', '财务费用'],
		selected: ['销售费用', '管理费用', '财务费用']
	},
	series: [
		{
			name: '费用',
			type: 'pie',
			radius: '50%',
			data: [{name: '销售费用', value: 0}, {name: '管理费用', value: 0}, {name: '财务费用', value: 0}],
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