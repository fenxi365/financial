<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">报表</span></div>
		<div class="h-panel-body">
			<Row :space="20">
				<Cell width="3" v-for="item in dataList" :key="item.id">
					<router-link :to="{name:'ReportView',params:{reportId:item.id}}" tag="div" class="report-item">{{item.name}}</router-link>
				</Cell>
			</Row>
		</div>
	</app-content>
</template>

<script>
	export default {
		name: "ReportList",
		data() {
			return {
				loading: false,
				templateModel: false,
				form: {
					name: '',
					templateKey: '',
					type: 0
				},
				validationRules: {
					required: ['name', 'templateKey'],
					rules: {
						templateKey: {
							valid: {
								pattern: /^[a-z]+$/i,
								message: '只能为纯字母'
							}
						}
					}
				},
				dataList: []
			}
		},
		methods: {
			loadList() {
				this.$api.report.template.list().then(({data}) => {
					this.dataList = data;
				});
			},
			save() {
				let validResult = this.$refs.templateForm.valid();
				if (validResult.result) {
					this.loading = true;
					this.$api.report.template.save(this.form).then(({data}) => {
						this.loadList();
					}).finally(() => {
						this.loading = false;
						this.templateModel = false;
					});
				}
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.report.template.delete(data.id).then(() => {
						this.loadList();
					})
				})
			}
		},
		mounted() {
			this.loadList();
		}
	}
</script>

<style scoped lang="less">
	.report {
		&-item {
			border-radius: 5px;
			border: 1px solid @primary-color;
			text-align: center;
			padding: 10px;

			&:hover {
				cursor: pointer;
				box-shadow: 0 0 20px 2px rgba(102, 100, 100, 0.24), 0px 2px 4px 0px rgba(199, 198, 198, 0.5);
			}
		}
	}
</style>