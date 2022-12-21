<template>
	<app-content class="h-panel">
		<div class="h-panel-bar">
			<span class="h-panel-title"><template v-if="subject">{{subject.name}}</template><template v-if="subject && subject.unit">(单位:{{subject.unit}})</template> - 明细账 </span>
		</div>
		<div class="margin-right-left margin-top">
			<account-date-choose v-model="accountDate"/>
			<div class="float-right">
				<Checkbox :disabled="numPriceDisabled" v-model="showNumPrice">显示数量金额</Checkbox>
			</div>
		</div>
		<Row class="h-panel-body" type="flex" :space-x="10">
			<Cell :flex="1" style="overflow-x: auto;">
				<table class="cus-table" v-if="!showNumPrice">
					<thead class="header">
					<tr>
						<td>日期</td>
						<td>凭证字号</td>
						<td>科目</td>
						<td>摘要</td>
						<td>借方</td>
						<td>贷方</td>
						<td>方向</td>
						<td>余额</td>
					</tr>
					</thead>
					<tbody>
					<tr v-for="item in datalist" :key="item.subjecId">
						<td>{{item.voucherDate}}</td>
						<td>
							<router-link v-if="item.voucherId" :to="{name:'VoucherForm',params:{voucherId:item.voucherId}}">{{item.word}}-{{item.code}}</router-link>
						</td>
						<td>{{item.subjectName}}</td>
						<td>{{item.summary}}</td>
						<td class="text-right">{{item.debitAmount|numFormat}}</td>
						<td class="text-right">{{item.creditAmount|numFormat}}</td>
						<td class="text-center">{{item.balanceDirection}}</td>
						<td class="text-right">{{item.balance|numFormat}}</td>
					</tr>
					<tr v-if="!datalist.length">
						<td colspan="8" class="text-center padding">暂无数据</td>
					</tr>
					</tbody>
				</table>
				<table class="cus-table" style="width: 1550px;" v-else>
					<thead class="header">
					<tr>
						<td rowspan="2" width="100">日期</td>
						<td rowspan="2" width="100">凭证字号</td>
						<td rowspan="2" width="150">科目</td>
						<td rowspan="2" width="200">摘要</td>
						<td colspan="3">借方发生额</td>
						<td colspan="3">贷方发生额</td>
						<td colspan="4">余额</td>
					</tr>
					<tr>
						<td width="100">数量</td>
						<td width="100">单价</td>
						<td width="100">金额</td>
						<td width="100">数量</td>
						<td width="100">单价</td>
						<td width="100">金额</td>
						<td width="100">方向</td>
						<td width="100">数量</td>
						<td width="100">单价</td>
						<td width="100">金额</td>
					</tr>
					</thead>
					<tbody>
					<tr v-for="item in datalist" :key="item.subjecId">
						<td>{{item.voucherDate}}</td>
						<td>
							<router-link v-if="item.voucherId" :to="{name:'VoucherForm',params:{voucherId:item.voucherId}}">{{item.word}}-{{item.code}}</router-link>
						</td>
						<td class="nowrap">{{item.subjectName}}</td>
						<td class="nowrap">{{item.summary}}</td>
						<td class="text-right">{{item.debitAmount&&item.balanceDirection=='借'?item.num:''}}</td>
						<td class="text-right">{{item.debitAmount&&item.balanceDirection=='借'?item.price:''}}</td>
						<td class="text-right">{{item.debitAmount|numFormat}}</td>
						<td class="text-right">{{item.creditAmount&&item.balanceDirection=='贷'?item.num:''}}</td>
						<td class="text-right">{{item.creditAmount&&item.balanceDirection=='贷'?item.price:''}}</td>
						<td class="text-right">{{item.creditAmount|numFormat}}</td>
						<td class="text-center">{{item.balanceDirection}}</td>
						<td class="text-right">{{item.numBalance|numFormat}}</td>
						<td class="text-right">{{item.price|numFormat}}</td>
						<td class="text-right">{{item.balance|numFormat}}</td>
					</tr>
					<tr v-if="!datalist.length">
						<td colspan="8" class="text-center padding">暂无数据</td>
					</tr>
					</tbody>
				</table>
			</Cell>
			<Cell v-width="200">
				<Tree v-model="subjectId" @select="subjectSelect" :option="param" ref="subject" filterable selectOnClick className="h-tree-theme-row-selected"></Tree>
			</Cell>
		</Row>
	</app-content>
</template>

<script>
	export default {
		name: 'DetailedAccounts',
		data() {
			return {
				loading: false,
				param: {
					keyName: 'id',
					parentName: 'parentId',
					titleName: 'subjectFullName',
					dataMode: 'list',
					datas: []
				},
				datalist: [],
				subjectId: null,
				showNumPrice: false,
				numPriceDisabled: true,
				accountDate: null,
				subject: null
			};
		},
		watch: {
			subject() {
				let org = this.showNumPrice;
				if (this.subject.unit) {
					this.numPriceDisabled = false;
					this.showNumPrice = true;
				} else {
					this.showNumPrice = false;
				}
				if (org == this.showNumPrice) {
					this.loadList();
				}
			},
			showNumPrice() {
				this.loadList();
			},
			accountDate() {
				this.loadSubject();
			}
		},
		methods: {
			loadSubject() {
				this.datalist = [];
				this.$api.accountbook.loadSubject({accountDate: this.accountDate}).then(({data}) => {
					this.$set(this.param, "datas", data);
					if (data.length) {
						this.subjectId = data[0].id;
						this.subject = data[0];
					}
				});
			},
			loadList() {
				this.loading = true;
				this.$api.accountbook.loadVoucherDetails({
					accountDate: this.accountDate,
					subjectId: this.subjectId,
					showNumPrice: this.showNumPrice,
					subjectCode: this.subject.code
				}).then(({data}) => {
					this.datalist = data;
					this.loading = false;
				});
			},
			subjectSelect(node) {
				this.subject = node;
			}
		}
	};
</script>
