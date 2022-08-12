<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">币别设置</span></div>
		<div class="margin-top margin-left">
			<Button color="primary" @click="showForm=true">新增</Button>
		</div>
		<div class="h-panel-body">
			<Table :datas="datas" :border="true">
				<TableItem title="币别" prop="code"></TableItem>
				<TableItem title="名称" prop="name"></TableItem>
				<TableItem title="汇率" prop="exchangeRate"></TableItem>
				<TableItem title="是否本位币">
					<template slot-scope="{data}">
						{{data.localCurrency?'是':'否'}}
					</template>
				</TableItem>
				<TableItem title="操作" :width="100" align="center">
					<div class="actions" slot-scope="{data}" v-if="!data.localCurrency">
						<span @click="edit(data)">编辑</span>
						<span @click="remove(data)">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="showForm" type="drawer-right" hasCloseIcon>
			<div slot="header">币别设置</div>
			<Form ref="form" v-width="400" :labelWidth="100" :model="form" :rules="validationRules">
				<FormItem label="币别" prop="code">
					<input type="text" v-model="form.code" @input="checkCode" maxlength="3">
				</FormItem>
				<FormItem label="名称" prop="name">
					<input type="text" v-model="form.name">
				</FormItem>
				<FormItem label="汇率" prop="exchangeRate">
					<NumberInput v-model="form.exchangeRate"></NumberInput>
				</FormItem>
			</Form>
			<div class="text-center">
				<Button color="green" @click="submit" :loading="loading">{{form.id?'更新':'保存'}}</Button>
				<Button @click="showForm=false" :loading="loading">取消</Button>
			</div>
		</Modal>
	</app-content>
</template>

<script>
	const emptyForm = {
		"code": "",
		"name": "",
		"exchangeRate": "",
	};

	export default {
		name: 'Currency',
		data() {
			return {
				datas: [],
				form: Object.assign({}, emptyForm),
				validationRules: {
					required: ["code", "name", "exchangeRate"],
					rules: {
						code: {
							maxLen: 3,
							minLen: 3,
							valid: {
								pattern: /^[A-Z]{3}$/,
								message: '需为三位的大写英文字母'
							}
						}
					}
				},
				showForm: false,
				loading: false
			};
		},
		watch: {
			showForm(val) {
				if (!val) {
					this.reset();
				}
			}
		},
		methods: {
			loadList() {
				this.$api.setting.currency.list().then(({data}) => {
					this.datas = data || [];
				})
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.$api.setting.currency[this.form.id ? 'update' : 'save'](this.form).then(() => {
						this.loadList();
						this.showForm = false;
						this.loading = false;
					}).catch(() => {
						this.loading = false;
					})
				}
			},
			reset() {
				this.form = Object.assign({}, emptyForm)
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.setting.currency.delete(data.id).then(() => {
						this.loadList();
					})
				})
			},
			edit(data) {
				this.form = Object.assign({}, data)
				this.showForm = true;
			},
			checkCode() {
				this.$set(this.form, 'code', this.form.code.toUpperCase());
			}
		},
		mounted() {
			this.loadList();
		}
	};
</script>