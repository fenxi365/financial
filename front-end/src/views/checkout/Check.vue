<template>
	<div class="h-list" style="width: 800px;margin: 20px auto">
		<div class="h-list-item">
			<div class="h-list-item-meta" v-for="(check,name) in checkList" :key="name">
				<span class="h-list-item-title font-bold">{{name}}：</span>
				<i v-if="check.loading" class="h-icon-loading"></i>
				<span v-if="check.msg" class="red-color">{{check.msg}}</span>
				<span v-else>{{check.loading ? '检查中...':'已完成'}}</span>
			</div>
		</div>
		<div class="text-center padding">
			<Button :loading="loading" @click="back">上一步</Button>
			<Button color="primary" :loading="loading" @click="invoicing" :disabled="!checked">结 账</Button>
		</div>
	</div>
</template>

<script>
	import {mapState} from 'vuex'

	export default {
		name: "Check",
		props: {
			checkYear: [Number, String],
			checkMonth: [Number, String],
		},
		data() {
			return {
				loading: false,
				checkList: {
					"期初检查": {
						loading: true
					},
					"期末检查": {
						loading: true
					},
					"报表检查": {
						loading: true
					},
					"断号检查": {
						loading: true
					}
				}
			};
		},
		computed: {
			...mapState(['currentAccountSets']),
			checked() {
				return Object.values(this.checkList).every(value => !value.loading && !value.msg);
			}
		},
		mounted() {
			this.init();
		},
		methods: {
			init() {
				this.$api.checkout.initialCheck({year: this.checkYear, month: this.checkMonth}).catch(() => {
					this.$set(this.checkList.期初检查, 'msg', "期初不平衡");
				}).finally(() => {
					this.$set(this.checkList.期初检查, 'loading', false);
				});

				this.$api.checkout.finalCheck({year: this.checkYear, month: this.checkMonth}).finally(() => {
					this.$set(this.checkList.期末检查, 'loading', false);
				}).catch(() => {
					this.$set(this.checkList.期末检查, 'msg', "期末不平衡");
				});

				this.$api.checkout.reportCheck({year: this.checkYear, month: this.checkMonth}).then(({data}) => {
					this.$set(this.checkList.报表检查, 'loading', false);
					if (!data.result) {
						let num = data.资产类 - data.负债类;
						this.$set(this.checkList.报表检查, 'msg', `资产负债不平衡，(资产(${data.资产类}) - 负债(${data.负债类}) = ${num} != 权益(${data.权益类}))，差额 ${(num - data.权益类).toFixed(2)}`);
					}
				});

				this.$api.checkout.brokenCheck({year: this.checkYear, month: this.checkMonth}).finally(() => {
					this.$set(this.checkList.断号检查, 'loading', false);
				}).catch(() => {
					this.$set(this.checkList.断号检查, 'msg', "凭证号不连续");
				});
			},
			invoicing() {
				this.loading = true;
				this.$api.checkout.invoicing({year: this.checkYear, month: this.checkMonth}).then(() => {
					this.$Message("结转成功！");
					this.$store.dispatch('init');
					this.$router.push({name: "CheckList"});
				}).finally(() => {
					this.loading = true;
				});
			},
			back() {
				this.$router.back();
			}
		}
	};
</script>

<style lang="less" scoped>
	.h-list-item-meta {
		margin: 20px;
	}
</style>
