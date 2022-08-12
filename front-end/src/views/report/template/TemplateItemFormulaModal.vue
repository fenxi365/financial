<template>
	<Modal v-model="showModal" hasCloseIcon hasDivider :closeOnMask="false">
		<div slot="header">编辑公式 - {{templateItem.title}}</div>
		<Row v-width="720" class="margin-top" type="flex" :space-x="20">
			<Cell class="label">{{templateItem.sources == 0?'科目':'项目名称'}}</Cell>
			<Cell>
				<DropdownCustom ref="dropdown" :toggleIcon="false" trigger="manual">
					<input v-width="150" type="text" v-model="kmFiler" @focus="$refs.dropdown.show()">
					<div style="min-width: 150px;" slot="content" class="voucher-select">
						<ul>
							<li v-for="v in voucherFilterSelect" :key="v.id" @click="doSelect(v)">
								{{v.subjectFullName}}
							</li>
						</ul>
					</div>
				</DropdownCustom>
			</Cell>
			<Cell class="label">运算符号</Cell>
			<Cell><Select v-model="form.calculation" dict="operation" placeholder="运算符号" v-width="100" :deletable="false"/></Cell>
			<template v-if="templateItem.sources == 0">
				<Cell class="label">取数规则</Cell>
				<Cell><Select v-model="form.accessRules" v-width="120" placeholder="取数规则" :dict="'accessRules'+type" :deletable="false"/></Cell>
			</template>
			<Cell>
				<Button color="primary" @click="addItem">添加</Button>
			</Cell>
		</Row>
		<Table class="margin-top" :datas="formulas" border>
			<TableItem :title="templateItem.sources == 0?'科目':'项目名称'">
				<template slot-scope="{data}">
					{{voucherSelectMap[data.fromTag].name}}
				</template>
			</TableItem>
			<TableItem title="运算符号" prop="calculation"/>
			<TableItem v-if="templateItem.sources == 0" title="取数规则" prop="accessRules" :dict="'accessRules'+type"/>
			<TableItem :width="100">
				<div class="actions" slot-scope="{data,index}">
					<span @click="removeItem(index)">删除</span>
				</div>
			</TableItem>
		</Table>
		<div slot="footer">
			<button class="h-btn" :loading="loading" @click="showModal=false">取消</button>
			<Button color="primary" :loading="loading" @click="save">保存</Button>
		</div>
	</Modal>
</template>

<script>
	export default {
		name: "TemplateItemFormulaModal",
		props: {
			templateItems: Array,
		},
		data() {
			return {
				showModal: false,
				loading: false,
				type: '0',
				kmFiler: '',
				voucherSelect: [],
				templateItem: {},
				form: {
					fromTag: null,
					calculation: '+',
					accessRules: '0',
				},
				formulas: []
			}
		},
		watch: {
			showModal(val) {
				if (!val) {
					this.kmFiler = "";
					this.$set(this.form, 'fromTag', null);
				}
			}
		},
		computed: {
			voucherSelectMap() {
				let map = {};
				this.voucherSelect.forEach(value => {
					map[value.id] = value;
				});
				return map;
			},
			voucherFilterSelect() {
				if (this.kmFiler) {
					return this.voucherSelect.filter(value => {
						return value.code.indexOf(this.kmFiler) !== -1 || value.name.indexOf(this.kmFiler) !== -1 || value.mnemonicCode.indexOf(this.kmFiler) !== -1;
					});
				}
				return this.voucherSelect;
			}
		},
		methods: {
			doSelect(v) {
				this.$set(this.form, 'fromTag', v.id);
				this.kmFiler = v.name;
				this.$refs.dropdown.hide();
			},
			toggle(templateItem, type) {
				this.templateItem = templateItem;
				this.type = type;
				this.formulas = Array.from(templateItem.formulas);
				this.showModal = !this.showModal;
				if (templateItem.sources === 0 && this.showModal) {
					this.loadVoucherSelect();
				} else {
					this.voucherSelect = this.templateItems.map(val => {
						return {
							id: val.id,
							name: val.title,
							subjectFullName: `(${val.lineNum})` + val.title,
							mnemonicCode: val.title,
							code: val.title
						};
					});
				}
			},
			save() {
				this.loading = false;
				Api.report.template.items.formula({
					formulas: this.formulas,
					templateItemsId: this.templateItem.id
				}).then(() => {
					this.showModal = false;
					this.$emit('success');
				}).finally(() => {
					this.loading = false;
				});
			},
			addItem() {
				if (this.form.fromTag) {
					if (this.formulas.find(value => value.fromTag === this.form.fromTag && value.calculation === this.form.calculation && value.accessRules === this.form.accessRules)) {
						this.$Message("已存在相同运算公式！");
						return
					}
					this.formulas.push(Object.assign({
						templateId: this.templateItem.templateId,
						templateItemsId: this.templateItem.id
					}, this.form));
					this.$set(this.form, 'fromTag', null);
					this.kmFiler = "";
				}
			},
			removeItem(idx) {
				this.formulas.splice(idx, 1);
			},
			loadVoucherSelect() {
				let tmp = localStorage.getItem('voucherSelectAll');
				if (tmp) {
					this.voucherSelect = JSON.parse(tmp);
				}
				Api.setting.subject.voucherSelect({showAll: true}).then(({data}) => {
					this.voucherSelect = data;
					localStorage.setItem("voucherSelectAll", JSON.stringify(data));
				});
			}
		},
	}
</script>

<style scoped lang="less">
	.voucher-select {
		max-height: 200px;
		overflow-y: auto;

		li {
			padding: 5px;
			cursor: pointer;

			&:hover {
				background-color: #dff7df;
			}
		}
	}
</style>