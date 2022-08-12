<template>
	<div>
		<div class="margin-top margin-left">
			<router-link tag="button" class="h-btn h-btn-primary" :to="{name:'TemplateDesign'}"> 新增</router-link>
		</div>
		<div class="h-panel-body">
			<Table :datas="datas" :border="true" :loading="loading">
				<TableItem title="模板名称" prop="name"></TableItem>
				<TableItem title="模板分类" prop="type" dict="voucherTemplateType"></TableItem>
				<TableItem>
					<div class="actions" slot-scope="{data}">
						<span class="text-hover" @click="open(data)">{{data._expand?'收起':'明细'}}</span>
						<router-link tag="span" :to="{name:'TemplateDesign',params:{templateId:data.id}}">设计模板</router-link>
						<span class="text-hover" @click="remove(data)">删除</span>
					</div>
				</TableItem>
				<template slot="expand" slot-scope="{index, data}">
					<table class="details">
						<tr>
							<td>摘要</td>
							<td>科目</td>
							<td>借方金额</td>
							<td>贷方金额</td>
						</tr>
						<tr v-for="d in data.details" :key="d.id">
							<td>{{d.summary}}</td>
							<td>{{d.subjectName}}</td>
							<td>{{d.debitAmount}}</td>
							<td>{{d.creditAmount}}</td>
						</tr>
					</table>
				</template>
			</Table>
		</div>
	</div>
</template>

<script>
	export default {
		name: 'TemplateManager',
		data() {
			return {
				datas: [],
				loading: false
			};
		},
		methods: {
			loadList() {
				this.loading = true;
				this.$api.setting.voucherTemplate.list().then(({data}) => {
					data.forEach(val => {
						val._expand = false;
					})
					this.datas = data;
					this.loading = false;
				})
			},
			open(data) {
				this.$set(data, '_expand', !data._expand);
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.setting.voucherTemplate.delete(data.id).then(() => {
						this.loadList();
					})
				})
			}
		},
		mounted() {
			this.loadList();
		}
	};
</script>

<style lang="less">

	.h-table-expand-cell {
		padding: 5px !important;

		.details td:last-child {
			border-right: 1px solid #eeeeee;
		}
	}
</style>
