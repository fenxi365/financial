<template>
	<app-content class="h-panel">
		<Tabs :datas="tabDatas" v-model="selected"></Tabs>
		<div class="h-panel-body padding">
			<router-view></router-view>
		</div>
	</app-content>
</template>
<script>
	export default {
		data() {
			return {
				selected: 'AccountingCategory',
				tabDatas: [{
					title: '辅助核算类别',
					key: 'AccountingCategory'
				}]
			};
		},
		watch: {
			selected(val) {
				if (val == 'AccountingCategory') {
					this.$router.push({name: val})
				} else {
					this.$router.push({name: 'CategoryCustom', params: {id: val}})
				}
			}
		},
		mounted() {
			this.init();
		},
		methods: {
			init() {
				if (this.$route.name == 'CategoryCustom') {
					this.selected = this.$route.params.id
				}
				this.$api.setting.accountingCategory.list().then(({data}) => {
					data.forEach(val => {
						this.tabDatas.push({
							title: val.name,
							key: val.id
						})
					});
				});
			},
			reloadTabs() {
				this.$api.setting.accountingCategory.list().then(({data}) => {
					let tabDatas = [{
						title: '辅助核算类别',
						key: 'AccountingCategory'
					}];
					data.forEach(val => {
						tabDatas.push({
							title: val.name,
							key: val.id
						});
					});
					this.tabDatas = tabDatas;
				});
			}
		}
	};
</script>
<style lang='less'>
	div.h-panel-bar {
		border-top: 0px solid #eeeeee
	}
</style>


