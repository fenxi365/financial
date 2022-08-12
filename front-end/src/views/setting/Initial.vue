<template>
	<app-content class="h-panel">
		<Tabs :datas="tabDatas" v-model="selected" @change="change"></Tabs>
		<div class="padding-top padding-right text-right">
      <Button @click="showImportModal=true">导入</Button>
      <a :href="downTemplateUrl" class="h-btn">导出</a>
			<Button @click="trialBalance">试算平衡</Button>
		</div>
		<div class="h-panel-body padding">
			<table class="cus-table">
				<thead class="header">
				<tr v-if="!isUnit">
					<td width="150">科目编码</td>
					<td nowrap>科目名称</td>
					<td width="100" nowrap>余额方向</td>
					<td width="150">期初余额</td>
					<td width="150">借方累计</td>
					<td width="150">贷方累计</td>
					<td width="150">年初余额</td>
				</tr>
				<template v-else>
					<tr>
						<td width="150" rowspan="2">科目编码</td>
						<td rowspan="2" nowrap>科目名称</td>
						<td width="100" rowspan="2" nowrap>余额方向</td>
						<td width="70" rowspan="2" nowrap>单位</td>
						<td colspan="2">期初余额</td>
						<td colspan="2">借方累计</td>
						<td colspan="2">贷方累计</td>
						<td colspan="2">年初余额</td>
					</tr>
					<tr>
						<td width="150">数量</td>
						<td width="150">金额</td>
						<td width="150">数量</td>
						<td width="150">金额</td>
						<td width="150">数量</td>
						<td width="150">金额</td>
						<td width="150">数量</td>
						<td width="150">金额</td>
					</tr>
				</template>
				</thead>
				<tbody>
				<tr v-for="(item,i) in datas" :key="i">
					<td :style="{paddingLeft:(item.level!=1?(item.level-1)*20:10)+'px'}">{{item.code}}</td>
					<td nowrap>
						{{item.name}} <i @click="addDetails(item)" class="fa fa-plus text-hover" v-if="item.auxiliaryAccounting" v-tooltip content="点击+号<br/>添加辅助明细"></i>
					</td>
					<td class="text-center">{{item.balanceDirection}}</td>
					<td class="text-center" v-if="isUnit">{{item.unit}}</td>
					<td class="text-center" v-if="isUnit" :class="{'edit-hover':(!item._numEdit && item.leaf && !item.auxiliaryAccounting && item.unit)}">
						<template v-if="item.unit && item.leaf && !item.auxiliaryAccounting">
							<div class="editblock edit-block" v-if="!item._numEdit" @dblclick="showInput($event,item,'_numEdit',i)">{{item.num|numFormat}}</div>
							<NumberInput :id="'_numEdit'+i" v-width="130" v-if="item._numEdit" v-model="item.num" @change="balanceChange(item,'_numEdit')"/>
						</template>
						<template v-else>
							{{item.num|numFormat}}
						</template>
					</td>
					<td class="text-right" :class="{'edit-hover':(!item._edit && item.leaf && !item.auxiliaryAccounting)}">
						<template v-if="item.leaf && !item.auxiliaryAccounting">
							<div class="editblock balance-edit-block" :data-code="item.code" :data-num="item.beginBalance" v-if="!item._edit" @dblclick="showInput($event,item,'_edit',i)">{{item.beginBalance|numFormat}}</div>
							<NumberInput :id="'_edit'+i" v-width="130" v-if="item._edit" v-model="item.beginBalance" @change="balanceChange(item,'_edit')"/>
						</template>
						<template v-else>
							<span class="balance" :data-code="item.code" :data-index="i">{{item.beginBalance|numFormat}}</span>
						</template>
					</td>
					<td class="text-center" v-if="isUnit" :class="{'edit-hover':(!item._cumulativeDebitNumEdit && item.leaf && !item.auxiliaryAccounting && item.unit)}">
						<template v-if="item.unit && item.leaf && !item.auxiliaryAccounting">
							<div class="editblock edit-block" v-if="!item._cumulativeDebitNumEdit" @dblclick="showInput($event,item,'_cumulativeDebitNumEdit',i)">{{item.cumulativeDebitNum|numFormat}}</div>
							<NumberInput :id="'_cumulativeDebitNumEdit'+i" v-width="130" v-if="item._cumulativeDebitNumEdit" v-model="item.cumulativeDebitNum" @change="balanceChange(item,'_cumulativeDebitNumEdit')"/>
						</template>
						<template v-else>
							{{item.cumulativeDebitNum|numFormat}}
						</template>
					</td>
					<td class="text-right" :class="{'edit-hover':(!item._cumulativeDebitEdit && item.leaf && !item.auxiliaryAccounting)}">
						<template v-if="item.leaf && !item.auxiliaryAccounting">
							<div class="editblock debit-edit-block" :data-code="item.code" :data-num="item.cumulativeDebit" v-if="!item._cumulativeDebitEdit" @dblclick="showInput($event,item,'_cumulativeDebitEdit',i)">{{item.cumulativeDebit|numFormat}}</div>
							<NumberInput :id="'_cumulativeDebitEdit'+i" v-width="130" v-if="item._cumulativeDebitEdit" v-model="item.cumulativeDebit" @change="balanceChange(item,'_cumulativeDebitEdit')"/>
						</template>
						<template v-else>
							<span class="debit" :data-code="item.code" :data-index="i">{{item.cumulativeDebit|numFormat}}</span>
						</template>
					</td>
					<td class="text-center" v-if="isUnit" :class="{'edit-hover':(!item._cumulativeCreditNumEdit && item.leaf && !item.auxiliaryAccounting && item.unit)}">
						<template v-if="item.unit && item.leaf && !item.auxiliaryAccounting">
							<div class="editblock edit-block" v-if="!item._cumulativeCreditNumEdit" @dblclick="showInput($event,item,'_cumulativeCreditNumEdit',i)">{{item.cumulativeCreditNum|numFormat}}</div>
							<NumberInput :id="'_cumulativeCreditNumEdit'+i" v-width="130" v-if="item._cumulativeCreditNumEdit" v-model="item.cumulativeCreditNum" @change="balanceChange(item,'_cumulativeCreditNumEdit')"/>
						</template>
						<template v-else>
							{{item.cumulativeCreditNum|numFormat}}
						</template>
					</td>
					<td class="text-right" :class="{'edit-hover':(!item._cumulativeCreditEdit && item.leaf && !item.auxiliaryAccounting)}">
						<template v-if="item.leaf && !item.auxiliaryAccounting">
							<div class="editblock credit-edit-block" :data-code="item.code" :data-num="item.cumulativeCredit" v-if="!item._cumulativeCreditEdit" @dblclick="showInput($event,item,'_cumulativeCreditEdit',i)">{{item.cumulativeCredit|numFormat}}</div>
							<NumberInput :id="'_cumulativeCreditEdit'+i" v-width="130" v-if="item._cumulativeCreditEdit" v-model="item.cumulativeCredit" @change="balanceChange(item,'_cumulativeCreditEdit')"/>
						</template>
						<template v-else>
							<span class="credit" :data-code="item.code" :data-index="i">{{item.cumulativeCredit|numFormat}}</span>
						</template>
					</td>
					<td class="text-center" v-if="isUnit">
						{{item.cumulativeCreditNum|numFormat}}
					</td>
					<td class="text-right">
						{{(item.beginBalance-(item.cumulativeDebit||0)+(item.cumulativeCredit||0))|numFormat}}
					</td>
				</tr>
				<tr v-if="!datas.length">
					<td colspan="8" class="text-center padding">暂无数据</td>
				</tr>
				</tbody>
			</table>
		</div>
		<Modal v-model="showModal" hasCloseIcon hasDivider>
			<div slot="header">期初试算结果</div>
			<Row class="result">
				<Cell :width="12" class="text-center" style="border-right: 1px solid #eeeeee">
					<div class="font-bold margin">期初余额</div>
					<div class="pic-body beginningBalance" :class="{left:beginningBalance.借<beginningBalance.贷,right:beginningBalance.借>beginningBalance.贷}">
						<span class="span1">{{beginningBalance.借|numFormat}}</span>
						<span class="span2">{{beginningBalance.借-beginningBalance.贷|numFormat}}</span>
						<span class="span3">{{beginningBalance.贷|numFormat}}</span>
						<div class="pic"></div>
					</div>
				</Cell>
				<Cell :width="12" class="text-center">
					<div class="font-bold margin">资产负债表期初</div>
					<div class="pic-body liabilities" :class="{left:liabilities.资产<liabilities.权益,right:liabilities.资产>liabilities.权益}">
						<span class="span1">{{liabilities.资产|numFormat}}</span>
						<span class="span2">{{liabilities.资产-liabilities.权益|numFormat}}</span>
						<span class="span3">{{liabilities.权益|numFormat}}</span>
						<div class="pic "></div>
					</div>
				</Cell>
			</Row>
		</Modal>
		<Modal v-model="showDetailModal" hasCloseIcon hasDivider>
			<div slot="header">增加明细</div>
			<Form v-width="400" :labelWidth="60" class="padding-right margin-top">
				<FormItem label="科目">
					<Select @change="subjectChange" v-model="auxiliary.subjectId" :datas="auxiliarys" :deletable="false" titleName="name" keyName="subjectId"></Select>
				</FormItem>
				<FormItem v-for="item in auxiliaryAccounting" :label="item.name" :key="item.id">
					<Select v-model="auxiliary.auxiliary[item.id]" :datas="auxiliaryAccountingData[auxiliary.subjectId]?auxiliaryAccountingData[auxiliary.subjectId][item.id]:[]" :deletable="false" titleName="name" keyName="id">
						<template slot-scope="{item}" slot="item">{{item.code}}-{{item.name}}</template>
					</Select>
				</FormItem>
			</Form>
			<div class="text-center margin-top">
				<Button color="green" @click="saveAuxiliary" :loading="loading">增加</Button>
				<Button @click="showDetailModal=false">取消</Button>
			</div>
		</Modal>
    <Modal v-model="showImportModal" :closeOnMask="false">
      <div slot="header">导入数据</div>
      <div v-width="350">
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
	</app-content>
</template>

<script>
	import {mapState} from 'vuex';
	import jQuery from 'jquery';

	const emptyForm = {
		"id": "0",
		"code": "",
		"name": "",
		"mnemonicCode": "",
		"balanceDirection": "",
		"status": "0",
		"parentId": "0"
	};

	export default {
		name: "Initial",
		data() {
			return {
				tabDatas: [
					{
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
				type: '资产',
				datas: [],
				form: Object.assign({}, emptyForm),
				showForm: false,
				showDetailModal: false,
				selected: 'CodeAssets',
				showModal: false,
				loading: false,
				temps: {},
				auxiliary: {subjectId: "", auxiliary: {}},
				auxiliaryAccounting: [],
				auxiliaryAccountingData: {},
				beginningBalance: {借: 0, 贷: 0},
				liabilities: {权益: 0, 资产: 0},
        showImportModal:false,
        file: null,
			};
		},
		computed: {
			...mapState(['currentAccountSets', 'currentOrgId']),
			isUnit() {
				return this.datas.filter(value => value.unit).length > 0;
			},
			auxiliarys() {
				return this.datas.filter(value => value.auxiliaryAccounting)
			},
      fileName() {
        if (this.file) {
          return this.file.name;
        }
        return '';
      },
      downTemplateUrl(){
        return Ajax.PREFIX + "/initial-balance/download";
      }
		},
		watch: {
			type() {
				this.loadList();
			}
		},
		methods: {
			showInput(e, item, type, i) {
				this.$set(item, type, true);
				this.$nextTick(() => {
					jQuery('.h-input', '#' + type + i).focus().select()
				});
			},
			addDetails(item) {
				this.auxiliary.subjectId = item.subjectId;
				this.subjectChange(item);
				this.showDetailModal = true;
			},
			addTemp(data) {
				this.temps[data.id] = data;
				return data.id;
			},
			loadList() {
				this.loading = true;
				this.$api.setting.initialBalance.list(this.type,this.currentOrgId).then(({data}) => {
					this.datas = data;
					this.loading = false;

					this.$nextTick(this.calParent);
				})
			},
			calParent() {
				let cals = {'balance': 'beginBalance', 'debit': 'cumulativeDebit', 'credit': 'cumulativeCredit'};
				Object.keys(cals).forEach(key => {
					jQuery(`span.${key}`).each((i, item) => {
						let {code, index} = item.dataset;
						let total = 0;
						jQuery(`.${key}-edit-block[data-code^=${code}]`).each((i, numItem) => {
							if (numItem.dataset.num) {
								total += Number(numItem.dataset.num)
							}
						});
						this.datas[index][cals[key]] = total;
					});
				});

				this.datas = Array.from(this.datas);
			},
			change(data) {
				this.type = data.title;
			},
			balanceChange(balance, target) {
				let params = {
					summary: "期初",
					subjectName: `${balance.code}-${balance.name}`,
					subjectCode: balance.code,
					subjectId: balance.subjectId,
					accountSetsId: balance.accountSetsId,
					cumulativeCredit: balance.cumulativeCredit,
					cumulativeDebit: balance.cumulativeDebit,
					cumulativeDebitNum: balance.cumulativeDebitNum,
					cumulativeCreditNum: balance.cumulativeCreditNum,
					num: balance.num
				};

				if (balance.balanceDirection === '借') {
					params.debitAmount = balance.beginBalance;
				} else {
					params.creditAmount = balance.beginBalance;
				}
				this.$api.setting.initialBalance.save(params).then(({data}) => {
					this.$set(balance, target, false);
					this.$nextTick(this.calParent);
				});
			},
			trialBalance() {
				this.$api.setting.initialBalance.trialBalance().then(({data}) => {
					this.showModal = true;
					this.beginningBalance = Object.assign(this.beginningBalance, data.beginningBalance);
					this.liabilities = Object.assign(this.liabilities, data.liabilities);
				});
			},
			subjectChange(subject) {
				this.auxiliaryAccounting = JSON.parse(subject.auxiliaryAccounting);
				this.loadAuxiliaryAccountingData(subject);
			},
			loadAuxiliaryAccountingData(subject) {
				if (!this.auxiliaryAccountingData[subject.subjectId]) {
					this.$api.setting.accountingCategoryDetails.loadAuxiliaryAccountingData(this.auxiliaryAccounting).then(({data}) => {
						this.$set(this.auxiliaryAccountingData, subject.subjectId, data);
					});
				}
			},
			saveAuxiliary() {
				if (this.auxiliary.subjectId && Object.keys(this.auxiliary.auxiliary).length === this.auxiliaryAccounting.length) {
					this.loading = true;
					this.$api.setting.initialBalance.saveAuxiliary(this.auxiliary).then(({data}) => {
						this.loadList();
						this.showDetailModal = false;
					}).finally(() => {
						this.loading = false;
					});
				}
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
		},
		mounted() {
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
		}
	};
</script>
<style lang="less" scoped>
	.result {
		width: 500px;
		height: 250px;

		.pic {
			width: 238px;
			height: 120px;
			background-image: url("../../assets/settings.png");
			background-repeat: no-repeat;
			margin: 20px auto;
		}


		.pic-body {
			margin-top: 50px;
			position: relative;

			&.beginningBalance {
				.pic {
					background-position: -160px 0px;
				}

				span {
					position: absolute;
				}

				.span1 {
					top: 0;
					left: 22px;
				}

				.span2 {
					top: 50px;
					left: 0;
					width: 100%;
				}

				.span3 {
					top: 0;
					right: 10px;
				}

				&.right {
					.pic {
						height: 130px;
						background-position: -160px -132px;
					}

					.span1 {
						top: 25px;
					}

					.span3 {
						top: -25px;
					}
				}

				&.left {
					.pic {
						height: 130px;
						background-position: -160px -272px;
					}

					.span1 {
						top: -25px;
					}

					.span3 {
						top: 25px;
					}
				}
			}

			&.liabilities {
				.pic {
					background-position: -420px 5px;
				}

				span {
					position: absolute;
				}

				.span1 {
					top: 0;
					left: 22px;
				}

				.span2 {
					top: 50px;
					left: 0;
					width: 100%;
				}

				.span3 {
					top: 0;
					right: 10px;
				}

				&.right {
					.pic {
						height: 130px;
						background-position: -420px -132px;
					}

					.span1 {
						top: 25px;
					}

					.span3 {
						top: -25px;
					}
				}

				&.left {
					.pic {
						height: 130px;
						background-position: -420px -272px;
					}

					.span1 {
						top: -25px;
					}

					.span3 {
						top: 25px;
					}
				}
			}
		}
	}

	.editblock {
		width: 100%;
		height: 100%;
		line-height: 33px;
	}

	.edit-hover:hover {
		cursor: pointer;
		background-color: @gray2-color;
	}
</style>
