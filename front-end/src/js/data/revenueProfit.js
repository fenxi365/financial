export default {
	tooltip: {
		trigger: 'axis',
		axisPointer: {            // 坐标轴指示器，坐标轴触发有效
			type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		},
		formatter: '{b1}<br>{a0} {c0}K<br>{a1} {c1}K'
	},
	legend: {
		data: ['本年利润', '主营业务收入']
	},
	grid: {
		left: '3%',
		right: '4%',
		bottom: '3%',
		containLabel: true
	},
	toolbox: {
		show: true,
		feature: {
			mark: {show: true},
			magicType: {show: true, type: ['line', 'bar']},
			restore: {show: true},
			saveAsImage: {show: true}
		}
	},
	calculable: true,
	xAxis: [
		{
			type: 'category',
			data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
		}
	],
	yAxis: [
		{
			type: 'value',
			axisLabel: {
				formatter: '{value} K'
			}
		}
	],
	series: [
		{
			name: '主营业务收入',
			type: 'bar',
			data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		},
		{
			name: '本年利润',
			type: 'bar',
			data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		}
	]
};