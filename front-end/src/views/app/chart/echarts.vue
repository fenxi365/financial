<template>
	<div class="echarts-vue"></div>
</template>

<script>
	import debounce from 'lodash.debounce';

	import echarts from 'echarts/index.simple';
	import 'echarts/extension/dataTool'
	import theme from './theme';

	export default {
		props: {
			options: {
				type: Object,
				default: () => ({})
			},
			initOption: {
				type: Object,
				default: () => ({})
			}
		},
		data() {
			return {
				chart: null
			};
		},
		mounted() {
			this.init();
		},
		watch: {
			options() {
				this.chart.setOption(this.options);
			}
		},
		methods: {
			init() {
				let chart = this.chart = echarts.init(this.$el, theme, this.initOption);
				this.chart.setOption(this.options);

				this.resizeHanlder = debounce(() => {
					chart.resize();
				}, 100, {leading: true});
				window.addEventListener('resize', this.resizeHanlder);
				this.listener = G.addlistener('page_resize', () => {
					chart.resize();
				});
			}
		},
		beforeDestroy() {
			window.removeEventListener('resize', this.resizeHanlder);
			G.removelistener(this.listener);
			this.chart.dispose();
			this.chart = null;
		},
		computed: {}
	};
</script>
<style lang="less">
	.echarts-vue {
		height: 360px;
		overflow: hidden;
	}
</style>