<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">报表模板</span></div>
		<div class="margin-top margin-left">
			<Button color="primary" @click="templateModel=true">添加</Button>
		</div>
		<div class="h-panel-body">
			<Table :datas="dataList" :loading="loading">
				<TableItem prop="name" title="名称"/>
				<TableItem prop="templateKey" title="标识"/>
				<TableItem prop="type" title="类型" dict="reportTemplateType"/>
				<TableItem>
					<div class="actions" slot-scope="{data}">
						<router-link :to="{name:'ReportView',params:{reportId:data.id}}" tag="span">预览</router-link>
						<router-link tag="span" :to="{name:'TemplateForm',params:{templateId:data.id}}">报表项目</router-link>
						<span @click="remove(data)">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="templateModel" hasCloseIcon hasDivider :closeOnMask="false">
			<div slot="header">模板信息</div>
			<Form :labelWidth="60" ref="templateForm" :rules="validationRules" :model="form">
				<FormItem label="名称" prop="name">
					<input v-model="form.name" type="text">
				</FormItem>
				<FormItem label="标识" prop="templateKey">
					<input v-model="form.templateKey" type="text">
				</FormItem>
				<FormItem label="类型">
					<Radio v-model="form.type" dict="reportTemplateType"></Radio>
				</FormItem>
			</Form>
			<div slot="footer">
				<Button @click="templateModel=false" :loading="loading">取消</Button>
				<Button color="primary" :loading="loading" @click="save()">添加</Button>
			</div>
		</Modal>
	</app-content>
</template>

<script>
	export default {
		name: "TemplateList",
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

<style scoped>

</style>