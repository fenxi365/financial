<template>
	<app-content class="app-home-vue frame-page">
		<template v-if="currentAccountSets">
			<Row :space="24">
				<Cell width="8">
					<div class="h-panel" style="height: 235px">
						<div class="h-panel-bar">
							<div class="h-panel-title">{{currentOrg.currentAccountDate|fqFormat}}</div>
							<div class="h-panel-right"><span class="gray-color">当期有</span><i class="h-split"></i><span class="font20 primary-color">{{voucherCount}}</span><i class="h-split"></i><span class="gray-color">张凭证</span></div>
						</div>
						<div class="text-hover h-panel-body progress-div home-part-body" align="center" @click="addVouch">
							<img src="../assets/voucherAdd.png" style="width: 100px;height: 100px"/>
							<p>新增凭证</p>
						</div>
					</div>
				</Cell>
				<Cell width="8">
					<div class="h-panel" style="height: 235px">
						<div class="h-panel-bar">
							<div class="h-panel-title">货币资金</div>
							<div class="h-panel-right"><span class="gray-color">总资金</span><i class="h-split"></i><span v-tooltip :content="cashTotal" class="font20 primary-color text-hover">{{cashTotal|moneyFormat}}</span><i class="h-split"></i><span class="gray-color">元</span></div>
						</div>
						<div class="h-panel-body">
							<Row style="line-height: 45px;" type="flex" v-for="cash in cashData" :key="cash.name">
								<Cell :flex="1">{{cash.name}}</Cell>
								<Cell><b class="text-hover" v-tooltip :content="cash.value">{{cash.value|moneyFormat}}</b>元</Cell>
							</Row>
						</div>
					</div>
				</Cell>
				<Cell width="8">
					<div class="h-panel" style="height: 235px">
						<div class="h-panel-bar">
							<div class="h-panel-title">费用统计</div>
							<div class="h-panel-right"><span class="gray-color">总费用</span><i class="h-split"></i><span v-tooltip :content="costTotal" class="font20 primary-color text-hover">{{costTotal|moneyFormat}}</span><i class="h-split"></i><span class="gray-color">元</span></div>
						</div>
						<div class="h-panel-body">
							<Row style="line-height: 45px;" type="flex" v-for="cash in costData" :key="cash.name">
								<Cell :flex="1">{{cash.name}}</Cell>
								<Cell><b class="text-hover" v-tooltip :content="cash.value">{{cash.value|moneyFormat}}</b>元</Cell>
							</Row>
						</div>
					</div>
				</Cell>
				<Cell width="24">
					<div class="h-panel">
						<div class="h-panel-body home-part-body2">
							<Row :space="20">
								<Cell :width="24">
									<Chart :options="revenueProfitOptions"></Chart>
								</Cell>
							</Row>
						</div>
					</div>
				</Cell>
			</Row>
		</template>
		<div class="h-panel" v-else>
			<div class="h-panel-bar"><span class="h-panel-title">初始化账套</span></div>
			<div class="h-panel-body">
				<Form ref="form" v-width="800" mode="twocolumn" :labelWidth="150" :model="form" :rules="validationRules">
					<FormItem label="单位名称:" prop="companyName">
						<input type="text" v-model="form.companyName">
					</FormItem>
					<FormItem label="账套启用年月:" prop="enableDate">
						<DatePicker type="month" v-model="form.enableDate"/>
					</FormItem>
					<FormItem label="统一社会信用代码:">
						<input type="text" v-model="form.creditCode">
					</FormItem>
					<FormItem label="会计准则:" prop="accountingStandards">
						<Radio v-model="form.accountingStandards" dict="accountingStandards"></Radio>
					</FormItem>
					<FormItem label="单位所在地:">
						<CategoryPicker ref="CategoryPicker" :option="pickerOption" type="key" showAllLevels v-model="form.address"></CategoryPicker>
					</FormItem>
					<FormItem label="行业:">
						<Select v-model="form.industry" dict="industry"></Select>
					</FormItem>
					<FormItem label="增值税种类:" prop="vatType">
						<Radio v-model="form.vatType" dict="vatRadios"></Radio>
					</FormItem>
					<FormItem label="凭证是否需要审核:" prop="voucherReviewed">
						<Radio v-model="form.voucherReviewed" dict="needRadios"></Radio>
					</FormItem>
					<FormItem single>
						<Button color="green" @click="submit" :loading="loading">创建账套</Button>
					</FormItem>
				</Form>
			</div>
		</div>
	</app-content>
</template>
<script>
import revenueProfit from '@/js/data/revenueProfit';
import {getTotalData} from '@/js/locations/district';
import {mapState} from 'vuex';
import moment from "moment";

const emptyForm = {
  "accountingStandards": "0",
  "address": null,
  "companyName": "",
  "creditCode": "",
  "enableDate": null,
  "fixedAssetModule": "0",
  "cashierModule": "0",
  "voucherReviewed": "0",
  "industry": "",
  "vatType": "0"
	};


	export default {
		name: 'Home',
		data() {
			return {
				revenueProfitOptions: revenueProfit,
				cashData: [{name: '库存现金', value: 0}, {name: '银行存款', value: 0}, {name: '其他货币资金', value: 0}],
				costData: [{name: '销售费用', value: 0}, {name: '管理费用', value: 0}, {name: '财务费用', value: 0}],
				voucherCount: 0,
				loading: false,
				datas: [],
				type: 'type1',
				pickerOption: {
					keyName: 'id',
					titleName: 'title',
					dataMode: 'list',
					parentName: 'parentId',
					datas: getTotalData()
				},
				form: Object.assign({}, emptyForm),
				validationRules: {
					required: ["companyName", "enableDate", "accountingStandards", "fixed_asset_module", "cashier_module", "voucherReviewed", "vatType"]
				}
			};
		},
		computed: {
			...mapState(['currentAccountSets','currentOrg']),
			costTotal() {
				let total = 0;
				this.costData.forEach(item => {
					total += item.value;
				});
				return total.toFixed(2);
			},
			cashTotal() {
				let total = 0;
				this.cashData.forEach(item => {
					total += item.value;
				});
				return total.toFixed(2);
			}
		},
		methods: {
			openMore() {
				this.$router.push({name: 'Chart'});
			},
			addVouch() {
				this.$router.push({name: 'VoucherForm'});
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.form.enableDate = moment(this.form.enableDate).format("YYYY-MM-DD");
					this.$api.setting.accountSets[this.form.id ? 'update' : 'save'](this.form).then(() => {
            window.location.replace("/");
					}).catch(() => {
						this.loading = false;
					})
				}
			},
			init() {
				if (this.currentAccountSets && this.currentOrg) {
					Promise.all([
						Api.home.voucherCount(),
						Api.home.chart.revenueProfit(),
						Api.home.chart.cost(),
						Api.home.chart.cash(),
					]).then((reslut) => {
						this.voucherCount = reslut[0].data;
						this.updateRevenueProfitOptions(reslut[1].data);

						this.cashData = reslut[3].data;
						this.costData = reslut[2].data;
					});
				}
			},
			updateRevenueProfitOptions(chartData) {
				let lr = chartData["本年利润"];
				let zysr = chartData["主营业务收入"];
				let opt = Object.assign({}, this.revenueProfitOptions);
				if (lr) {
					Object.keys(lr).forEach(value => {
						opt.series[1].data[value - 1] = (lr[value] / 1000).toFixed(2);
					});
				}
				if (zysr) {
					Object.keys(zysr).forEach(value => {
						opt.series[0].data[value - 1] = (zysr[value] / 1000).toFixed(2);
					});
				}
				this.revenueProfitOptions = opt;
			}
		},
		mounted() {
			this.init();
		}
	};
</script>

