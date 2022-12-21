<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">账套管理</span></div>
		<div class="margin-top margin-left">
			<Button color="primary" @click="showForm=true">新建账套</Button>&nbsp;&nbsp;当前账套数量为{{datas.length}}个&nbsp;&nbsp;
		</div>
		<div class="h-panel-body">
			<Table :datas="datas" :border="true">
				<TableItem :width="80" align="center">
					<template slot-scope="{data}">
						<span class="h-tag h-tag-bg-green" v-if="data.id == User.accountSetsId">当前</span>
					</template>
				</TableItem>
				<TableItem title="单位名称" prop="companyName"></TableItem>
				<TableItem title="当前记账年月" prop="currentAccountDate" :width="120" :format="dateFormat"></TableItem>
				<TableItem title="账套启用年月" prop="enableDate" :width="120" :format="dateFormat"></TableItem>
				<TableItem title="会计准则" prop="accountingStandards" dict="accountingStandards" :width="200"></TableItem>
				<TableItem title="凭证审核" prop="voucherReviewed" dict="enableRadios" :width="100"></TableItem>
				<TableItem title="操作" :width="100" align="center">
					<div class="actions" slot-scope="{data}">
						<span @click="edit(data)">编辑</span>
						<span @click="remove(data)" v-if="User.role === 'Manager'">删除</span>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="showForm" type="drawer-right" hasCloseIcon>
			<div slot="header">创建账套</div>
			<Form ref="form" v-width="800" mode="twocolumn" :labelWidth="150" :model="form" :rules="validationRules">
				<FormItem label="单位名称:" prop="companyName">
					<input type="text" v-model="form.companyName">
				</FormItem>
				<FormItem label="账套启用年月:" prop="enableDate">
					<DatePicker type="month" v-model="form.enableDate" :disabled="used"/>
				</FormItem>
				<FormItem label="统一社会信用代码:">
					<input type="text" v-model="form.creditCode">
				</FormItem>
				<FormItem label="会计准则:" prop="accountingStandards">
					<Radio v-model="form.accountingStandards" dict="accountingStandards" :disabled="!!form.id"></Radio>
				</FormItem>
				<FormItem label="单位所在地:">
					<CategoryPicker ref="CategoryPicker" :option="pickerOption" type="key" showAllLevels v-model="form.address"></CategoryPicker>
				</FormItem>
				<!--	<FormItem label="固定资产模块:" prop="fixedAssetModule">
						<Radio v-model="form.fixedAssetModule" dict="enableRadios"></Radio>
					</FormItem>-->
				<FormItem label="行业:">
					<Select v-model="form.industry" dict="industry"></Select>
				</FormItem>
				<!--	<FormItem label="是否启用出纳模块:" prop="cashierModule">
						<Radio v-model="form.cashierModule" dict="enableRadios"></Radio>
					</FormItem>-->
				<FormItem label="增值税种类:" prop="vatType">
					<Radio v-model="form.vatType" dict="vatRadios"></Radio>
				</FormItem>
				<FormItem label="凭证是否需要审核:" prop="voucherReviewed">
					<Radio v-model="form.voucherReviewed" dict="needRadios"></Radio>
				</FormItem>
			</Form>
			<div class="text-center">
				<Button color="green" @click="submit" :loading="loading">{{form.id?'更新':'创建'}}账套</Button>
				<Button @click="showForm=false">取消</Button>
			</div>
		</Modal>
		<Modal v-model="showModal" hasCloseIcon>
			<div slot="header">删除账套</div>
			<div>
				<div>您正在删除账套：<b>{{rmData.companyName}}</b><br>为保障数据安全，需要短信验证身份。</div>
				<Row type="flex" :space="10" class="margin">
					<Cell><input type="text" v-model="User.mobile" disabled></Cell>
					<Cell>
						<SmsVerificationCode :mobile="User.mobile"/>
					</Cell>
				</Row>
				<Row type="flex" :space="10" class="margin">
					<Cell><input v-model="msgCode" type="number" placeholder="请输入验证码"></Cell>
				</Row>
			</div>
			<div class="text-center">
				<Button color="red" :disabled="!this.msgCode" @click="doRemove" :loading="loading">删除</Button>
				<Button @click="showModal=false">取消</Button>
			</div>
		</Modal>
	</app-content>
</template>

<script>
	import {getTotalData} from '../../js/locations/district';
	import moment from 'moment';
	import {mapState} from 'vuex';
	import SmsVerificationCode from "../../components/SmsVerificationCode";

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
		name: 'Account',
		components: {SmsVerificationCode},
		data() {
			return {
				datas: [],
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
				},
				showModal: false,
				rmData: {},
				msgCode: '',
				showForm: false,
				used: false,
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
		computed: {
			...mapState(["User"])
		},
		methods: {
			loadList() {
				this.$api.setting.accountSets.list().then(({data}) => {
					this.datas = data || [];
				})
			},
			submit() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.form.enableDate = moment(this.form.enableDate).format("YYYY-MM-DD");
					this.$api.setting.accountSets[this.form.id ? 'update' : 'save'](this.form).then(() => {
						this.$store.dispatch('init');
						this.loadList();
						this.showForm = false;
						this.loading = false;
					}).catch(() => {
						this.loading = false;
					})
				}
			},
			reset() {
				this.form = Object.assign({}, emptyForm);
				this.used = false;
			},
			dateFormat(val) {
				return val ? moment(val).format("YYYY年MM月") : '';
			},
			remove(data) {
				this.showModal = true;
				this.rmData = data;
			},
			doRemove() {
				if (this.msgCode) {
					this.$Confirm("确认删除?").then(() => {
						this.$api.setting.accountSets.delete(this.rmData.id, this.msgCode).then(() => {
							this.loadList();
							this.$store.dispatch('init');
							this.showModal = false;
							this.rmData = {};
							this.msgCode = '';
						})
					})
				}
			},
			edit(row) {
				Api.setting.accountSets.checkUse(row.id).then(({data}) => {
					this.used = data;
					this.form = Object.assign({}, row);
					this.showForm = true;
				})
			}
		},
		mounted() {
			this.loadList();
		}
	};
</script>
