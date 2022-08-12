<template>
	<div>
		<div class="h-panel-search margin-bottom">
			<Button color="primary" @click="showForm=true" v-show="canAdd">自定义辅助核算</Button>
		</div>
		<div>
			<Table :datas="datas" :border="true">
				<TableItem title="名称" prop="name"></TableItem>
				<TableItem title="操作" :width="150" align="center">
					<div class="actions" slot-scope="{data}" v-if="!data.systemDefault">
						<span @click="edit(data)">编辑</span>
						<span @click="remove(data)" v-if="data.canEdit">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="showForm" hasCloseIcon type="drawer-right">
			<div slot="header">核算类别设置</div>
			<Form ref="form" v-width="600" :labelWidth="120" :model="form" :rules="validationRules">
				<FormItem label="辅助核算类别" prop="name">
					<input type="text" v-model="form.name" maxlength="4" :readonly="!form.canEdit">
				</FormItem>
				<FormItem label="默认列">
					<Row :space="10" type="flex">
						<Cell><input type="text" value="编码" readonly v-width="150"></Cell>
						<Cell><input type="text" value="名称" readonly v-width="150"></Cell>
						<Cell><input type="text" value="备注" readonly v-width="150"></Cell>
					</Row>
				</FormItem>
				<FormItem label="自定义列" prop="customColumns">
					<Row :space="10" type="flex">
						<Cell v-for="(c,i) in form.customColumns" :key="i">
							<div class="h-input h-input-suffix-icon">
								<input :placeholder="'自定义列'+(i+1)" type="text" v-model="form.customColumns[i]" v-width="150" :readonly="!form.canEdit">
								<i class="h-icon-trash" v-if="form.canEdit" @click="deleteItem(i)"></i>
							</div>
						</Cell>
						<Cell>
							<Button v-if="form.customColumns.length < 8 && form.canEdit" color="green" @click="addColumn">添加列</Button>
						</Cell>
					</Row>
				</FormItem>
			</Form>
			<div class="text-center">
				<Button color="green" :disabled="!form.canEdit" @click="submit" :loading="loading">{{form.id?'更新':'保存'}}</Button>
				<Button @click="showForm=false">取消</Button>
			</div>
		</Modal>
	</div>
</template>
<script>

	const emptyForm = {
		"id": "",
		"name": "",
		"canEdit": true,
		"customColumns": [],
	};
	export default {
		name: "AccountingCategory",
		data() {
			return {
				datas: [],
				form: Object.assign({}, emptyForm),
				validationRules: {
					required: ["name"],
					rules: {
						code: {
							maxLen: 4
						}
					}
				},
				showForm: false,
				loading: false
			};
		},
		computed: {
			canAdd() {
				if (this.datas.length) {
					return this.datas.filter(val => !val.systemDefault).length < 3;
				}
				return false;
			}
		},
		watch: {
			showForm(val) {
				if (!val) {
					this.reset();
				}
			}
		},
		methods: {
			addColumn() {
				this.form.customColumns.push("")
			},
			loadList() {
				this.$api.setting.accountingCategory.list().then(({data}) => {
					this.datas = data || [];
				})
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.$api.setting.accountingCategory[this.form.id ? 'update' : 'save'](Object.assign({}, this.form, {customColumns: this.form.customColumns.join(",")})).then(() => {
						this.loadList();
						if (!this.form.id) {
							this.reloadTabs();
						}
						this.showForm = false;
						this.loading = false;
					}).catch(() => {
						this.loading = false;
					})
				}
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.setting.accountingCategory.delete(data.id).then(() => {
						this.loadList();
						this.reloadTabs();
					})
				})
			},
			edit(data) {
				this.form = Object.assign({}, data, {customColumns: data.customColumns.length ? data.customColumns.split(',') : []});
				this.showForm = true;
			},
			deleteItem(i) {
				this.form.customColumns.splice(i, 1);
			},
			reset() {
				this.form = Object.assign({}, emptyForm, {customColumns: []});
			},
			reloadTabs() {
				this.$parent.$parent.reloadTabs();
			}
		},
		mounted() {
			this.loadList();
		}
	};
</script>
<style lang='less'>
	div.h-input-suffix-icon {
		.h-icon-trash {
			display: none;
			cursor: pointer;
		}

		&:hover {
			.h-icon-trash {
				display: inline-block;
			}
		}
	}
</style>
