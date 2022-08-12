<template>
	<app-content class="h-panel">
		<Tabs :datas="tabDatas" v-model="selected" @change="change"></Tabs>
		<div class="padding-right-left padding-top">
			<span class="dark4-color">*提示：按 Ctrl + F 键并输入科目编码或者科目名称可以查找科目。</span>
			<div class="pull-right">
				<Button @click="create()" v-if="currentAccountSets.accountingStandards !== 0" color="primary">新增科目</Button>
				<Button @click="encodingSetting">编码设置</Button>
				<Button :loading="loading" @click="doUpload">
					<input ref="file" type="file" accept="application/vnd.ms-excel" style="display: none" @change="fileChange($event)">
					导入
				</Button>
        <a :href="downloadUrl" class="h-btn">导出</a>
			</div>
		</div>
		<div class="h-panel-body padding">
			<Table :datas="datas" border :loading="loading">
				<TableItem title="科目编码">
					<template slot-scope="{data}">
						<span :style="{paddingLeft:(data.level-1)*15+'px'}">{{data.code}}</span>
					</template>
				</TableItem>
				<TableItem title="科目名称" prop="name"></TableItem>
				<TableItem title="助记码" prop="mnemonicCode"></TableItem>
				<TableItem title="余额方向" prop="balanceDirection" align="center" :width="100"></TableItem>
				<TableItem title="数量核算" v-if="showUnit" prop="unit" align="center" :width="100"></TableItem>
				<TableItem title="辅助核算" v-if="showAssistAccounting">
					<template slot-scope="{data:{auxiliaryAccounting}}">
						{{auxiliaryAccounting?JSON.parse(auxiliaryAccounting).map(val=>val.name).join(','):''}}
					</template>
				</TableItem>
				<TableItem title="状态" align="center" :width="100">
					<template slot-scope="{data}">
						{{data.status?"正常":"不可用"}}
					</template>
				</TableItem>
				<TableItem title="操作" :width="150" align="center">
					<div class="actions" slot-scope="{data}">
						<span @click="create(data)" v-if="data.level < 3">新增</span>
						<span v-if="!data.isLeaf" @click="edit(data)">编辑</span>
						<span v-if="!data.systemDefault" @click="remove(data)">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="showForm" type="drawer-right" hasCloseIcon>
			<div slot="header">新增科目</div>
			<Form :readonly="used" ref="form" v-width="800" mode="twocolumn" :labelWidth="150" :model="form" :rules="validationRules">
				<img v-if="used" class="used" src="@/assets/used.png" alt="已使用">
				<FormItem label="科目编码" prop="code">
					<div class="h-input-group" v-if="!form.id && parent">
						<span class="h-input-addon bg-white-color" style="padding-right: 0;border-right: none;line-height: 32px;;color: #001529;">{{parent.code}}</span>
						<input style="padding-left: 0;border-left: none;" type="text" v-model="form.code" :maxlength="len">
					</div>
					<input v-else-if="!form.id && !parent" type="text" v-model="form.code" :maxlength="len">
					<input v-else type="text" v-model="form.code" disabled>
				</FormItem>
				<FormItem label="科目名称" prop="name">
					<input type="text" v-model="form.name" :disabled="form.systemDefault || used">
				</FormItem>
				<FormItem label="上级科目">
					<input type="text" :value="parentSubject" disabled>
				</FormItem>
				<FormItem label="余额方向">
					<Radio v-model="form.balanceDirection" :datas="['借','贷']" :disabled="parent"/>
				</FormItem>
				<FormItem label="状态">
					<Radio v-model="form.status" dict="statusRadios" :disabled="used"></Radio>
				</FormItem>
				<FormItem single label="">
					<Row type="flex" :space-x="10">
						<Cell>
							<Checkbox v-model="numberAccounting" :disabled="used">数量核算</Checkbox>
						</Cell>
						<template v-if="numberAccounting">
							<Cell class="label">计量单位</Cell>
							<Cell><input type="text" v-width="100" v-model="unit" :disabled="used"></Cell>
						</template>
					</Row>
				</FormItem>
				<FormItem single label="">
					<Row type="flex" :space-x="10">
						<Cell>
							<Checkbox v-model="assistAccounting" :disabled="used">辅助核算</Checkbox>
						</Cell>
						<template v-if="assistAccounting">
							<Cell>
								<Checkbox v-model="auxiliaryAccounting" :datas="accountingCategory" keyName="id" titleName="name" :disabled="used"></Checkbox>
							</Cell>
						</template>
					</Row>
				</FormItem>
			</Form>
			<div class="text-center">
				<Button color="green" @click="submit" :disabled="used" :loading="loading">{{form.id?'保存':'保存'}}</Button>
				<Button @click="showForm=false">取消</Button>
			</div>
		</Modal>
		<Modal v-model="encodingSettingForm">
			<div slot="header">科目编码设置</div>
			<div class="padding">
				科目编码设置：4 - <Select v-model="codeLen[1]" style="display: inline-block;" :datas="lenData" :deletable="false"/> - <Select v-model="codeLen[2]" style="display: inline-block;" :datas="lenData" :deletable="false"/> - <Select v-model="codeLen[3]" style="display: inline-block;" :datas="lenData2" :deletable="false"/>
			</div>
			<div class="text-center">
				<Button color="green" @click="saveEncoding" :loading="loading">保存</Button>
				<Button @click="encodingSettingForm=false" :loading="loading">取消</Button>
			</div>
		</Modal>
	</app-content>
</template>

<script>

	import Pinyin from 'chinese-to-pinyin'
	import StringUtils from 'string-utilz'
	import {mapState} from 'vuex';

	const emptyForm = {
		"code": "",
		"name": "",
		"mnemonicCode": "",
		"balanceDirection": "借",
		"auxiliaryAccounting": null,
		"status": true
	};

	export default {
		name: "Subject",
		data() {
			return {
				codeLen: [4, 2, 2, 2],
				lenData: [2, 3, 4],
				lenData2: [1, 2, 3, 4],
				tabDatas: [{
					title: '资产',
					key: 'CodeAssets'
				}, {
					title: '负债',
					key: 'CodeLiabilities'
				}, {
					title: '权益',
					key: 'CodeInterest'
				}, {
					title: '成本',
					key: 'CodeCost'
				}, {
					title: '损益',
					key: 'CodeLoss'
				}],
				datas: [],
				accountingCategory: [],
				auxiliaryAccounting: [],
				unit: '',
				validationRules: {
					required: ["code", "name"]
				},
				parent: null,
				len: 2,
				encodingSettingForm: false,
				numberAccounting: false,
				assistAccounting: false,
				form: HeyUtils.copy(emptyForm),
				showForm: false,
				used: false,
				type: "资产",
				selected: 'CodeAssets',
				loading: false
			};
		},
		computed: {
			...mapState(['currentAccountSets']),
			parentSubject() {
				return this.parent ? this.parent.name : '';
			},
			showUnit() {
				return this.datas.find(value => !!value.unit)
			},
			showAssistAccounting() {
				return this.datas.find(value => !!value.auxiliaryAccounting)
			},
      downloadUrl() {
        return Ajax.PREFIX + "/subject/download";
      },
		},
		watch: {
			type() {
				this.loadList()
			},
			showForm(val) {
				if (!val) {
					this.parent = null;
					this.used = false;
					this.form = HeyUtils.copy(emptyForm);
					this.numberAccounting = false;
					this.assistAccounting = false;
					this.unit = '';
					this.auxiliaryAccounting = [];
				}
			},
			numberAccounting(val) {
				if (!val) {
					this.form.unit = '';
				}
			}
		},
		methods: {
			encodingSetting() {
				this.encodingSettingForm = true;
			},
			saveEncoding() {
				let code = this.codeLen.join('-');
				if (code !== this.currentAccountSets.encoding) {
					this.loading = true;
					this.$api.setting.accountSets.updateEncode({encoding: this.currentAccountSets.encoding, newEncoding: code}).finally(() => {
						this.encodingSettingForm = false;
						this.loading = false;
					}).then(() => {
						this.loadList();
						this.$store.dispatch('init');
					});
				} else {
					this.encodingSettingForm = false;
				}
			},
			toPy() {
				let pyArr = [];
				this.form.name.split("").forEach(w => {
					w = w.trim();
					if (w) {
						if (/[\u4e00-\u9fa5]/.test(w)) {
							let py = Pinyin(w, {removeTone: true, keepRest: true}).trim();
							pyArr.push(py.substring(0, 1));
						} else {
							pyArr.push(w);
						}
					}
				});

				if (this.parent) {
					this.$set(this.form, 'mnemonicCode', this.parent.mnemonicCode + "_" + pyArr.join(""));
					if (!this.form.id) {
						this.$set(this.form, 'code', this.parent.code + this.form.code);
					}
				} else {
					this.$set(this.form, 'mnemonicCode', pyArr.join(""));
				}
			},
			loadList() {
				this.loading = true;
				this.$api.setting.subject.list(this.type).then(({data}) => {
					this.datas = data || [];
					this.loading = false
				});
			},
			loadAccountingCategory() {
				this.$api.setting.accountingCategory.list().then(({data}) => {
					this.accountingCategory = data;
				});
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.toPy();
					this.loading = true;

					if (this.assistAccounting && this.auxiliaryAccounting.length) {
						this.form.auxiliaryAccounting = JSON.stringify(this.auxiliaryAccounting.map(value => {
							let act = this.accountingCategory.find(item => item.id == value);
							return {id: act.id, name: act.name};
						}));
					} else {
						this.form.auxiliaryAccounting = '';
					}

					if (this.numberAccounting && this.unit) {
						this.form.unit = this.unit;
					} else {
						this.form.unit = '';
					}

					this.$api.setting.subject[this.form.id ? 'update' : 'save'](Object.assign(this.form)).then(() => {
						this.loadList();
						this.showForm = false;
						this.loading = false;
					}).catch(() => {
						this.loading = false;
					})
				}
			},
			create(data) {
				this.parent = data;
				if (!data) {
					data = {level: 0, type: this.type, balanceDirection: '借'};
				}
				this.showForm = true;
				let children = this.datas.filter(value => value.parentId == data.id);
				let len = this.codeLen[data.level];
				this.len = len;
				let start = "1";
				if (children.length) {
					let code = children[children.length - 1].code;
					start = (parseInt(code.substr(code.length - len)) + 1) + "";
				}
				this.form.code = StringUtils.pad(start, 0 - (len - start.length), "0");
				this.form.type = data.type;
				this.form.parentId = data.id;
				this.form.level = data.level + 1;
				this.form.balanceDirection = data.balanceDirection;
			},
			change(data) {
				this.type = data.title;
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.setting.subject.delete(data.id).then(() => {
						this.loadList();
					})
				})
			},
			edit(row) {
				Api.setting.subject.checkUse(row.id).then(({data}) => {
					this.used = data;
					this.parent = this.datas.find(value => value.id == row.parentId);
					this.numberAccounting = !!row.unit;
					this.assistAccounting = !!row.auxiliaryAccounting;
					this.unit = row.unit;
					if (row.auxiliaryAccounting) {
						this.auxiliaryAccounting = JSON.parse(row.auxiliaryAccounting).map(val => val.id);
					}
					this.form = Object.assign({}, row);
					this.showForm = true;
				});
			},
			doUpload() {
				this.$refs.file.click();
			},
			fileChange(e) {
				if (this.$refs.file.files.length) {
					let formData = new FormData();
					formData.append('file', this.$refs.file.files[0]);
					this.loading = true;
					this.$api.setting.subject.import(formData).then(({data}) => {
						this.$Message("亲,导入成功~");
						this.loadList();
					}).finally(() => {
						this.loading = false;
					});
					this.$refs.file.value = "";
				}
			}
		},
		mounted() {
			this.codeLen = this.currentAccountSets.encoding.split("-").map(value => parseInt(value));
			if (this.currentAccountSets.accountingStandards !== 0) {
				this.tabDatas = [{
					title: '资产',
					key: 'CodeAssets'
				}, {
					title: '负债',
					key: 'CodeLiabilities'
				}, {
					title: '共同',
					key: 'Common'
				}, {
					title: '权益',
					key: 'CodeInterest'
				}, {
					title: '成本',
					key: 'CodeCost'
				}, {
					title: '损益',
					key: 'CodeLoss'
				}];
			}
			this.loadList();
			this.loadAccountingCategory();
		}
	};
</script>

<style scoped>
	div.h-tabs.h-tabs-card {
		border-bottom: 1px solid #52abc50d;
	}

	div.h-panel-body {
		padding-top: 0px;
	}

	div.h-panel-bar {
		border-bottom: 0px solid #eeeeee;
		border-top: 1px solid #eeeeee;
	}

	.used {
		position: absolute;
		right: 50px;
		z-index: 10;
		top: 0;
	}
</style>
