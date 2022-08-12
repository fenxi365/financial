<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">凭证字</span></div>
		<div class="margin-top margin-left">
			<Button color="primary" @click="showForm=true">新增</Button>
		</div>
		<div class="h-panel-body">
			<Table :datas="datas" :border="true">
				<TableItem title="凭证字" prop="word"></TableItem>
				<TableItem title="打印标题" prop="printTitle" :width="120"></TableItem>
				<TableItem title="是否默认" :width="100">
					<template slot-scope="{data}">
						{{data.isDefault?'是':'否'}}
					</template>
				</TableItem>
				<TableItem title="操作" :width="100" align="center">
					<div class="actions" slot-scope="{data}">
						<span @click="edit(data)">编辑</span>
						<span @click="remove(data)">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="showForm" hasCloseIcon type="drawer-right">
			<div slot="header">凭证字设置</div>
			<Form ref="form" v-width="400" :labelWidth="100" :model="form" :rules="validationRules">
				<FormItem label="凭证字" prop="word">
					<input type="text" v-model="form.word">
				</FormItem>
				<FormItem label="打印标题" prop="printTitle">
					<input type="text" v-model="form.printTitle">
				</FormItem>
				<FormItem label="是否默认" prop="isDefault">
					<Radio v-model="form.isDefault" dict="defaultRadios"></Radio>
				</FormItem>
			</Form>
			<div class="text-center">
				<Button color="green" @click="submit" :loading="loading">{{form.id?'更新':'保存'}}</Button>
				<Button @click="showForm=false">取消</Button>
			</div>
		</Modal>
	</app-content>
</template>

<script>
	const emptyForm = {
		"word": "",
		"printTitle": "",
		"isDefault": 0,
	};

	export default {
		name: 'VoucherWord',
		data() {
			return {
				datas: [],
				form: Object.assign({}, emptyForm),
				validationRules: {
					required: ["word", "printTitle", "isDefault"]
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
				this.$api.setting.voucherWord.list().then(({data}) => {
					this.datas = data || [];
				})
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.$api.setting.voucherWord[this.form.id ? 'update' : 'save'](this.form).then(() => {
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
					this.$api.setting.voucherWord.delete(data.id).then(() => {
						this.loadList();
					})
				})
			},
			edit(data) {
				this.form = Object.assign({}, data)
				this.showForm = true;
			}
		},
		mounted() {
			this.loadList();
		}
	};
</script>
