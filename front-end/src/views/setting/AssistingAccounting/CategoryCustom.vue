<template>
	<div>
		<div class="h-panel-search">
			<Row type="flex" :space-x="10">
				<Cell style="line-height: 32px;">输入编码或名称：</Cell>
				<Cell><input type="text" v-model="keyword" @keydown.enter="doSearch"></Cell>
				<Cell>
					<Button color="green" @click="doSearch"> 查询</Button>
				</Cell>
				<Cell :flex="1" class="text-right">
					<Button color="primary" @click="showForm=true">新增</Button>
					<Button @click="showImportModal=true">导入</Button>
					<a :href="downloadUrl" class="h-btn">导出</a>
					<Button @click="clearData">清空</Button>
				</Cell>
			</Row>
		</div>
		<div>
			<Table :datas="datas" border>
				<TableItem :title="category.name+'编码'" prop="code" :width="100"></TableItem>
				<TableItem :title="category.name+'名称'" prop="name" :width="150"></TableItem>
				<TableItem v-for="(col,i) in customColumns" :title="col" :prop="'cusColumn'+i" :key="col"></TableItem>
				<TableItem title="备注" prop="remark"></TableItem>
				<TableItem title="操作" :width="120" align="center">
					<div class="actions" slot-scope="{data}">
						<span @click="edit(data)">编辑</span>
						<span @click="remove(data)">删除</span>
					</div>
				</TableItem>
			</Table>
			<div class="margin-top-bottom">
				<Pagination v-model="pageInfo" align="center" layout="pager" small/>
			</div>
		</div>
		<Modal v-model="showForm" type="drawer-right" hasCloseIcon>
			<div slot="header">辅助核算设置 - {{category.name}}</div>
			<Form ref="form" v-width="800" mode="twocolumn" :labelWidth="150" :model="form" :rules="validationRules">
				<FormItem :label="category.name+'编码'" prop="code">
					<input type="text" v-model="form.code" maxlength="3">
				</FormItem>
				<FormItem :label="category.name+'名称'" prop="name">
					<input type="text" v-model="form.name">
				</FormItem>
				<FormItem v-for="(col,i) in customColumns" :label="col" :key="i">
					<DatePicker v-model="form['cusColumn'+i]" v-if="col.indexOf('日期') != -1"/>
					<input v-else type="text" v-model="form['cusColumn'+i]">
				</FormItem>
				<FormItem label="备注" prop="remark" single>
					<NumberInput v-model="form.remark"></NumberInput>
				</FormItem>
				<FormItem label="是否启用" prop="enable" single>
					<Radio v-model="form.enable" dict="defaultRadios"/>
				</FormItem>
			</Form>
			<div class="text-center">
				<Button color="green" @click="submit" :loading="loading">{{form.id?'更新':'保存'}}</Button>
				<Button @click="showForm=false" :loading="loading">取消</Button>
			</div>
		</Modal>
		<Modal v-model="showImportModal" :closeOnMask="false">
			<div slot="header">批量导入 {{category.name}} 数据</div>
			<div class="padding" v-width="350">
				<p>第一步： 请点击下面的链接下载Excel模板，并按照模板填写信息</p>
				<a class="blue-color text-hover" :href="downTemplateUrl">下载模板</a>
				<p>第二步： 导入Excel模板文件</p>
				<span class="blue-color text-hover" @click="$refs.file.click()">选取文件</span><span class="margin-left" v-if="fileName">已选：{{fileName}}</span>
				<input type="file" style="visibility: hidden;" @change="fileChange($event)" ref="file">
			</div>
			<div class="text-center">
				<Button color="green" @click="importData" :disabled="!fileName" :loading="loading">导入</Button>
				<Button @click="showImportModal=false" :loading="loading">取消</Button>
			</div>
		</Modal>
	</div>
</template>
<script>

	const emptyForm = {
		"code": "",
		"name": "",
		"enable": true
	};
	export default {
		name: "CategoryCustom",
		props: {
			id: [Number, String]
		},
		data() {
			return {
				keyword: '',
				file: null,
				datas: [],
				columns: [],
				category: {},
				customColumns: [],
				form: Object.assign({}, emptyForm),
				validationRules: {
					required: ["code", "name"],
				},
				showForm: false,
				showImportModal: false,
				loading: false,
				pageInfo: {
					page: 1,
					total: 0
				}
			};
		},
		computed: {
			downTemplateUrl() {
				return Ajax.PREFIX + "/accounting-category/template?categoryId=" + this.id;
			},
			downloadUrl() {
				return Ajax.PREFIX + "/accounting-category/download?categoryId=" + this.id;
			},
			fileName() {
				if (this.file) {
					return this.file.name;
				}
				return '';
			}
		},
		watch: {
			showForm(val) {
				if (!val) {
					this.reset();
				}
			},
			id() {
				this.reset();
				this.init();
			},
			pageInfo: {
				deep: true,
				handler() {
					this.loadList();
				}
			}
		},
		mounted() {
			this.init();
		},
		methods: {
			doSearch() {
				this.pageInfo.page = 1;
				this.loadList();
			},
			init() {
				this.$api.setting.accountingCategory.load(this.id).then(({data}) => {
					this.category = data;
					this.customColumns = data.customColumns.length ? data.customColumns.split(",") : [];
					//加载数据
					this.$nextTick(() => {
						this.loadList();
					});
				})
			},
			loadList() {
				this.$api.setting.accountingCategoryDetails.list(this.id, {page: this.pageInfo.page, keyword: this.keyword}).then(({data}) => {
					this.datas = data.records;
					this.$set(this.pageInfo, 'total', data.total);
				})
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.$api.setting.accountingCategoryDetails[this.form.id ? 'update' : 'save'](Object.assign({
						accountingCategoryId: this.category.id
					}, this.form)).then(() => {
						this.loadList();
						this.showForm = false;
						this.loading = false;
					}).catch(() => {
						this.loading = false;
					})
				}
			},
			edit(data) {
				this.form = Object.assign({}, data);
				this.showForm = true;
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.setting.accountingCategoryDetails.delete(data.id).then(() => {
						this.loadList();
					})
				});
			},
			reset() {
				this.form = Object.assign({}, emptyForm);
			},
			clearData() {
				this.$Confirm("亲，您确认要清空所有的数据吗?").then(() => {
					this.$api.setting.accountingCategoryDetails.clearData(this.category.id).then(() => {
						this.loadList();
					})
				});
			},
			fileChange() {
				this.file = this.$refs.file.files[0];
			},
			importData() {
				if (this.file) {
					let formData = new FormData();
					formData.append('file', this.file);
					formData.append('categoryId', this.id);
					this.loading = true;
					this.$api.setting.accountingCategory.import(formData).then(({data}) => {
						this.$Message(`本次导入数据共:${data.total}行。其中更新${data.updated}行，新增${data.inserted}行。`);
						this.pageInfo.page = 1;
						this.showImportModal = false;
						this.loadList();
					}).finally(() => {
						this.loading = false;
					});
					this.file = null;
					this.$refs.file.value = "";
				}
			}
		}
	};
</script>
<style lang='less'>
	div.h-panel-search {
		margin-bottom: 10px;
	}
</style>
