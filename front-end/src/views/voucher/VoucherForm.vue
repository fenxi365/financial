<template>
	<app-content style="position: relative;">
		<div class="mask" v-if="User.role =='View' || form.auditMemberId"></div>
		<div class="h-panel" style="width: 1000px;margin: 0 auto;padding-top: 20px;">
			<img v-if="form.auditMemberId" class="auditpic" src="@/assets/audit.png" alt="已审核">
			<div class="padding-right-left">
				<Row type="flex" :space-x="10">
					<Cell v-if="User.role !='View'">
						<template v-if="isCheck">
							<Button v-if="isCheck" @click="$router.back()">返回</Button>
							<Button :disabled="!canSave" color="primary" @click="save(true)" :loading="loading">保存</Button>
						</template>
						<template v-else>
							<Button :disabled="!canSave" color="primary" @click="save(true)" :loading="loading" v-if="!form.id">保存并新增</Button>
							<Button :disabled="!!form.auditMemberId" color="primary" @click="toNew()" v-else>新增</Button>
							<Button :disabled="!canSave || !!form.auditMemberId" color="primary" @click="save(false)" :loading="loading">保存</Button>
							<template v-if="form.id && currentAccountSets.voucherReviewed">
								<Button v-if="form.auditMemberId" color="primary" @click="cancelAudit" :loading="loading">取消审核</Button>
								<Button v-else color="primary" @click="audit" :loading="loading">审核</Button>
							</template>
						</template>
					</Cell>
					<Cell v-if="!isCheck">
						<a class="h-btn" :href="`/api/pfd/voucher?id=${form.id}`" target="_blank">打印</a>
					</Cell>
					<Cell :flex="1" class="text-right" v-if="!isCheck">
						<ButtonGroup>
							<Button :loading="loading" @click="before" size="s" v-tooltip content="上一条" icon="h-icon-left"></Button>
							<Button :loading="loading" @click="next" size="s" v-tooltip content="下一条" icon="h-icon-right"></Button>
						</ButtonGroup>
					</Cell>
				</Row>
				<Row class="margin-top" type="flex" :space-x="10">
					<Cell>
						<Select @change="loadCode" keyName="word" titleName="word" style="min-width: 70px" :deletable="false" :datas="voucherWords" v-model="form.word" placeholder="记"/>
					</Cell>
					<Cell class="label">
						<NumberInput :min="1" v-model="form.code" v-width="90" style="display: inline-block"/>
						号
					</Cell>
					<Cell class="label">
						日期：
					</Cell>
					<Cell class="label">
						<DatePicker :disabled="!!carryForward" :option="dpOps" :clearable="false" v-model="form.voucherDate" format="YYYY-MM-DD"/>
					</Cell>
					<Cell class="label">
						<DropdownCustom :toggle-icon="false" class-name="h-text-dropdown">
							<span class="text-hover blue-color font-bold">备注</span>
							<div slot="content" v-width="200">
								<textarea placeholder="请输入备注内容" v-model="form.remark" v-autosize rows="3" style="width: 100%;"></textarea>
							</div>
						</DropdownCustom>
					</Cell>
				</Row>
			</div>
			<voucher-table ref="voucherTable" v-model="voucherTable"/>
			<div class="padding-right-left padding-bottom">
				制单人：{{User.realName}}
			</div>
		</div>
	</app-content>
</template>

<script>
	import VoucherTable from "../../components/VoucherTable";
	import {mapState} from 'vuex';
	import moment from 'moment';

	export default {
		name: "VoucherForm",
		components: {VoucherTable},
		inject: ['reload'],
		props: {
			voucherId: [Number, String],
		},
		computed: {
			...mapState(['User', 'currentAccountSets']),
			voucherItems() {
				return this.voucherTable.voucherItems;
			},
			canSave() {
				return this.voucherItems.length > 0
			},
			isCheck() {
				return !!this.$route.params.checkData
			}
		},
		data() {
			return {
				loading: false,
				carryForward: false,
				voucherWords: [],
				voucherTable: {voucherItems: []},
				dpOps: {
					start: moment().toDate()
				},
				voucher: {},
				form: {
					remark: '',
					word: '',
					code: '',
					voucherDate: '',
					carryForward: false,
				}
			}
		},
		watch: {
			'form.word'(val, old) {
				if (!old && this.voucherId) {
					return;
				}
				val && this.loadCode();
			},
			voucherId(val) {
				if (!val) {
					this.reload()
				} else {
					this.init();
				}
			}
		},
		beforeRouteLeave(to, from, next) {
			next();
		},
		methods: {
			loadVoucherWords() {
				this.$api.setting.voucherWord.list().then(({data}) => {
					this.voucherWords = data || [];
					this.form.word = data.find(value => value.isDefault).word
				})
			},
			loadCode() {
				this.$api.voucher.loadCode({
					word: this.form.word,
					currentAccountDate: this.form.voucherDate
				}).then(({data}) => {
					this.form.code = data
				})
			},
			toNew() {
				this.$router.push({name: 'VoucherForm'});
			},
			save(next) {
				if (!this.form.code) {
					this.$Message("亲，请输入编号！");
					return
				}

				if (!this.voucherItems.length) {
					this.$Message("亲，第1行不能为空！");
					return
				}

				if (this.checkItem("摘要", 'summary') || this.checkItem("科目", 'subjectId') || this.checkItem("金额")) {
					return
				}

				if (this.voucherTable.jfTotal != this.voucherTable.dfTotal) {
					this.$Message("亲，借贷不平衡！");
					return
				}

				this.loading = true;
				this.$api.voucher[this.voucherId ? 'update' : 'save'](Object.assign({}, this.form, {details: this.voucherItems, createMember: this.User.id})).then(({success, data}) => {
					if (success && !this.form.id) {
						if (next) {
							if (!this.isCheck) {
								this.reload();
							} else {
								this.$router.back();
							}
						} else {
							this.$router.push({name: 'VoucherForm', params: {voucherId: data.id}});
						}
					}

					this.loading = false;
					this.$Message("亲，保存成功！");

					//如果是结转凭证就返回
					if (this.$route.params.checkData) {
						this.$router.back();
					}
				}).catch(() => {
					this.loading = false;
				});
			},
			checkItem(name, field) {
				let i = 0, len = this.voucherItems.length, row = -1;
				for (; i < len; i++) {
					if ((field && !this.voucherItems[i][field]) || (!field && !this.voucherItems[i].debitAmount && !this.voucherItems[i].creditAmount)) {
						row = i + 1;
						break;
					}
				}

				if (row > -1) {
					this.$Message(`亲，第${row}行，请输入${name}！`);
					return true;
				}
			},
			before() {
				this.loading = true;
				this.$api.voucher.beforeId({currentId: this.voucherId}).then(({data}) => {
					if (data) {
						this.$router.push({name: 'VoucherForm', params: {voucherId: data}})
					} else {
						this.$Message("亲，已经没有上一条啦！")
					}
				}).finally(() => {
					this.loading = false;
				});
			},
			next() {
				this.loading = true;
				this.$api.voucher.nextId({currentId: this.voucherId}).then(({data}) => {
					if (data) {
						this.$router.push({name: 'VoucherForm', params: {voucherId: data}})
					} else {
						this.$Message("亲，已经没有下一条啦！")
					}
				}).finally(() => {
					this.loading = false;
				});
			},
			init() {
				if (this.voucherId) {
					this.$api.voucher.load(this.voucherId).then(({data}) => {
						this.$refs.voucherTable.initValue(data.details);
						this.voucher = data;
						this.form = {
							id: data.id,
							auditMemberId: data.auditMemberId,
							word: data.word,
							remark: data.remark,
							voucherDate: data.voucherDate,
							carryForward: data.carryForward,
							code: data.code
						};
					})
				} else {
					this.form.voucherDate = moment(this.currentAccountSets.currentAccountDate).endOf('month').format('YYYY-MM-DD');
				}

				//结转凭证初始化
				let params = this.$route.params;
				if (params.checkData) {
					this.carryForward = !!params.type.code;
					this.form.voucherDate = moment(params.checkData.checkYear + "-" + params.checkData.checkMonth).endOf('month').format('YYYY-MM-DD');
					let {subject, name} = params.type;

					let details = [];
					this.$api.setting.subject.loadByCode(subject, Object.assign(params.checkData, {name})).then(({data}) => {
						let creditAmount = 0, debitAmount = 0;
						data.subject.forEach(sub => {
							let amount = data.amount[sub.code];
							let detail = {
								summary: `第${params.checkData.checkMonth}期 ${name}`,
								subject: sub,
								subjectId: sub.id,
								subjectName: `${sub.code}-${sub.name}`,
								subjectCode: sub.code
							};
							if (amount) {
								if (amount.creditAmount) {
									details.push(Object.assign({}, detail, {[name === '结转损益' ? 'debitAmount' : 'creditAmount']: amount.creditAmount}));
									creditAmount += amount.creditAmount;
								}

								if (amount.debitAmount) {
									details.push(Object.assign({}, detail, {[name === '结转损益' ? 'creditAmount' : 'debitAmount']: amount.debitAmount}));
									debitAmount += amount.debitAmount;
								}
							} else if (name !== '结转损益' || sub.name === '本年利润') {
								details.push(detail);
							}
						});

						if (name === '结转损益') {
							this.form.carryForward = true;
							details.forEach((value, index) => {
								if (value.subject.name === '本年利润') {
									delete value.debitAmount;
									let amount = debitAmount - creditAmount;
									if (amount > 0) {
										value.debitAmount = amount;
									} else {
										value.creditAmount = Math.abs(amount);
									}
								}
							});
						}

						this.$refs.voucherTable.initValue(details);
					});
				}
				this.loadVoucherWords();
			},
			audit() {
				this.$Confirm("亲，确认要审核吗?").then(() => {
					this.loading = true;
					this.$api.voucher.audit({checked: [this.voucher.id], year: this.voucher.voucherYear, month: this.voucher.voucherMonth}).then(() => {
						this.reload();
						this.$Message("审核成功！");
					}).finally(() => {
						this.loading = false;
					});
				});
			},
			cancelAudit() {
				this.$Confirm("亲，确认要取消审核吗?").then(() => {
					this.loading = true;
					this.$api.voucher.cancelAudit({checked: [this.voucher.id], year: this.voucher.voucherYear, month: this.voucher.voucherMonth}).then(() => {
						this.reload();
						this.$Message("取消审核成功！");
					}).finally(() => {
						this.loading = false;
					});
				});
			}
		},
		mounted() {
			this.$set(this.dpOps, "start", moment(this.currentAccountSets.enableDate).toDate());
			this.init();
		}
	}
</script>

<style scoped>
	.mask {
		position: absolute;
		height: 100%;
		width: 100%;
		z-index: 100;
		bottom: 0;
		top: 110px;
	}

	.auditpic {
		position: absolute;
		z-index: 100;
		right: 100px;
	}
</style>
