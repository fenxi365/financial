<template>
	<div class="h-panel-body padding font-bold">
		<Row :space="9">
			<Cell width="6" v-for="(type,i) in typeList" :key="i">
				<div>
					<p>{{type.name}}</p>
					<p class="pnumber" v-if="money[type.code] && (money[type.code].debitAmount||money[type.code].creditAmount)">{{money[type.code].debitAmount||money[type.code].creditAmount|numFormat}}</p>
					<p class="pnumber" v-else>0.00</p>
					<router-link v-if="money[type.code]" tag="button" :to="{name:'VoucherForm', params: { voucherId: money[type.code].voucherId}}" class="h-btn h-btn-green">查看凭证</router-link>
					<router-link v-else tag="button" :to="{name:'VoucherForm', params: { checkData,type }}" class="h-btn h-btn-primary">生成凭证</router-link>
				</div>
			</Cell>
		</Row>
		<div align="center" style="margin-top: 20px;">
			<button class="h-btn h-btn-text-primary h-btn-transparent" @click="back">上一步</button>
			<button class="h-btn h-btn-primary" @click="check">下一步</button>
		</div>
	</div>
</template>

<script>
	import {mapState} from 'vuex';
	import StringUtils from 'string-utilz';

	export default {
		name: "checkout",
		props: {
			checkYear: [Number, String],
			checkMonth: [Number, String],
		},
		computed: {
			...mapState(['currentAccountSets','currentOrgId']),
			typeList() {
				let isQy = this.currentAccountSets.accountingStandards === 0;
				return [
					{
						code: isQy ? '5401' : '6401',
						type: 'jzxscb',
						name: '结转销售成本',
						subject: isQy ? [5401, 1405] : [6401, 1405]
					},
					{
						code: '2211',
						type: 'jtzgxc',
						name: '计提职工薪酬',
						subject: isQy ? [this.codeConversion(560201), this.codeConversion(560101), 2211] : [this.codeConversion(660201), this.codeConversion(660101), 2211]
					},
					{
						code: '1602',
						type: 'jtzj',
						name: '计提折旧',
						subject: isQy ? [this.codeConversion(560207), 1602] : [this.codeConversion(660207), this.codeConversion(660107), 1602]
					},
					{
						code: '1801',
						type: 'txdtfy',
						name: '摊销待摊费用',
						subject: isQy ? [this.codeConversion(560212), 1801] : [this.codeConversion(660212), 1801]
					},
					{
						code: isQy ? '5401' : '6403',
						type: 'jtsj',
						name: '计提税金',
						subject: isQy ? [5403, this.codeConversion(222108), this.codeConversion(222113), this.codeConversion(222114)] : [6403, this.codeConversion(222108), this.codeConversion(222113), this.codeConversion(222114)]
					},
					{
						code: this.codeConversion('222102'),
						type: 'jzwjzzs',
						name: '结转未交增值税',
						subject: [this.codeConversion(22210103), this.codeConversion(222102)]
					},
					{
						code: isQy ? '5401' : '6801',
						type: 'jtsds',
						name: '计提所得税',
						subject: isQy ? [5801, this.codeConversion(222106)] : [6801, this.codeConversion(222106)]
					},
					{
						code: isQy ? '3103' : '4103',
						type: 'jzsy',
						name: '结转损益',
						subject: isQy ? [3103] : [4103]
					}
				]
			}
		},
		data() {
			return {
				selected: 'carry-forward',
				checkData: {},
				money: {}
			}
		},
		methods: {
			check() {
				this.$router.push({name: 'Check', params: this.checkData})
			},
			back() {
				this.$router.back()
			},
			init() {
				this.$api.voucher.carryForwardMoney({
					years: this.checkYear,
					month: this.checkMonth,
					orgId: this.currentOrgId,
					code: this.typeList.map(val => val.code)
				}).then(({data}) => {
					this.money = data;
				});
			},
			codeConversion(code) {
				code = String(code);
				let encoding = this.currentAccountSets.encoding.split('-');
				let reg = RegExp(`^\\d{4}(\\d{${encoding[1]}|\\d{${encoding[1]}\\d{${encoding[2]}|\\d{${encoding[1]}\\d{${encoding[2]}\\d{${encoding[3]})$`);
				if (!reg.test(code)) {
					code = this.updateCode(code, [4, 2, 2, 2], encoding);
				}
				return code;
			},
			updateCode(code, model, newModel) {
				let codeSp = [];
				let start = 0;
				for (let i in model) {
					let len = model[i];
					if (code.length <= start) {
						break;
					}
					codeSp.push(code.substring(start, Math.min(code.length, start + len)));
					start += len;
				}

				for (let i = 0; i < codeSp.length; i++) {
					let item = codeSp[i];
					let len = parseInt(newModel[i]);
					if (item) {
						if (item.length < len) {
							item = StringUtils.pad(item, item.length - len, "0");
						} else if (item.length > len) {
							item = item.substring(item.length - len);
						}
						codeSp[i] = item;
					}
				}

				return codeSp.join("");
			}
		},
		mounted() {
			this.checkData = {checkYear: this.checkYear, checkMonth: this.checkMonth};
			this.init();
		}
	}
</script>

<style lang="less" scoped>
	.h-row > div > div {
		padding: 8px;
		color: #000;
		border-radius: 3px;
		text-align: center;
		background-color: #Fff;
		height: 150px;
		line-height: 36px;
		border: 1px solid #eee;
	}

	.pnumber {
		margin: 5px 0;
		font-size: larger;
	}

</style>
