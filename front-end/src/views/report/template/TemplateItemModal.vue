<template>
	<Modal v-model="templateItemModel" hasCloseIcon hasDivider :closeOnMask="false">
		<div slot="header">编辑项目</div>
		<Form v-width="700" mode="twocolumn" :labelWidth="90" ref="templateItemForm" :rules="validationTifRules" :model="templateItemForm">
			<FormItem label="项目名称" prop="title">
				<Row type="flex" :space-x="10">
					<Cell :flex="1"><input v-model="templateItemForm.title" type="text"></Cell>
					<Cell>
						<Checkbox v-model="templateItemForm.isClassified" v-tooltip content="归类项不需要设置行号和公式">归类项</Checkbox>
					</Cell>
				</Row>
			</FormItem>
			<FormItem label="上级项目" prop="parent">
				<Select type="object" v-model="parent" :datas="templateItems" keyName="id">
					<template slot-scope="{item}" slot="item">
						<span :style="{paddingLeft:(item.level*10)+'px'}">{{item.title}}</span>
					</template>
				</Select>
			</FormItem>
			<FormItem label="行次" prop="lineNum" v-if="!templateItemForm.isClassified">
				<NumberInput :min="1" v-model="templateItemForm.lineNum" useOperate/>
			</FormItem>
			<FormItem label="取数来原" prop="sources" v-if="!templateItemForm.isClassified">
				<Radio v-model="templateItemForm.sources" dict="reportTemplateItemSources"></Radio>
			</FormItem>
			<FormItem single label="类别" prop="type" v-if="template.type == 1 && !templateItemForm.isClassified">
				<Radio v-model="templateItemForm.type" dict="reportTemplateItemType"></Radio>
			</FormItem>
			<FormItem label="名称加粗" prop="sources">
				<Radio v-model="templateItemForm.isBolder" dict="defaultRadios"></Radio>
			</FormItem>
			<FormItem label="是否折叠" prop="sources">
				<Radio v-model="templateItemForm.isFolding" dict="defaultRadios"></Radio>
			</FormItem>
			<FormItem label="显示位置" prop="pos">
				<NumberInput :min="1" v-model="templateItemForm.pos" useOperate/>
			</FormItem>
		</Form>
		<div slot="footer">
			<Button :loading="loading" @click="templateItemModel=false">取消</Button>
			<Button color="primary" :loading="loading" @click="addItem">保存</Button>
		</div>
	</Modal>
</template>
<script>
	export default {
		name: 'TemplateItemModal',
		props: {
			template: {},
			templateItems: Array
		},
		data() {
			return {
				parent: null,
				loading: false,
				templateItemModel: false,
				templateItemForm: {
					title: '',
					lineNum: 1,
					isClassified: false,
					sources: 0,
					type: 0,
					isBolder: 0,
					isFolding: 0,
					pos: 1,
					level: 1
				}
			}
		},
		computed: {
			validationTifRules() {
				let required = ['title'];
				if (!this.templateItemForm.isClassified) {
					required = required.concat(['lineNum', 'sources']);
				}
				return {required};
			},
			maxLineNum() {
				let lineNum = 1;
				if (this.templateItems.length > 0) {
					this.templateItems.forEach(val => {
						lineNum = Math.max(lineNum, val.lineNum);
					});
					lineNum++;
				}
				return lineNum;
			}
		},
		watch: {
			templateItemModel(val) {
				!val && this.resetForm();
			}
		},
		methods: {
			resetForm() {
				this.templateItemForm = {title: '', pos: 1, isClassified: false, lineNum: this.maxLineNum, sources: 0, type: 0, level: 1, isBolder: 0, isFolding: 0};
				this.parent = null;
			},
			addItem() {
				let validResult = this.$refs.templateItemForm.valid();
				if (validResult.result) {
					if (this.parent) {
						if (this.parent.level) {
							this.templateItemForm.level = this.parent.level + 1;
						}
						this.templateItemForm.parentId = this.parent.id;
					}
					this.loading = true;
					Api.report.template.items[this.templateItemForm.id ? 'update' : 'save'](Object.assign(this.templateItemForm, {template_id: this.template.id})).then(() => {
						this.templateItemModel = false;
						this.$emit("success");
					}).finally(() => {
						this.loading = false;
					});
				}
			},
			toggle(parent, org) {
				this.templateItemModel = !this.templateItemModel;
				this.parent = parent;
				this.templateItemForm.lineNum = this.maxLineNum;
				if (org != null) {
					this.templateItemForm = Object.assign({}, org);
				}
			}
		},
	}
</script>
