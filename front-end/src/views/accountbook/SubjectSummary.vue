<template>
	<app-content class="h-panel">
		<div class="h-panel-bar">
			<span class="h-panel-title">科目汇总</span>
		</div>
		<div class="margin-right-left margin-top">
			<account-date-choose v-model="accountDate"/>
			<div class="float-right">
				<Checkbox v-model="showNumPrice">显示数量金额</Checkbox>
			</div>
		</div>
		<div class="h-panel-body" type="flex" :space-x="10">
			<table class="balance" v-if="!showNumPrice">
				<thead class="header">
				<tr>
					<td rowspan="2" v-width="100">科目编码</td>
					<td rowspan="2" v-width="200">科目名称</td>
					<td colspan="2">金额合计</td>
				</tr>
				<tr>
					<td>借方</td>
					<td>贷方</td>
				</tr>
				</thead>
				<tbody>
				<tr v-for="item in dataList" :key="item.subjecId">
					<td :style="{'padding-left':(item.level)*10+'px'}">{{item.code}}</td>
					<td :style="{'padding-left':(item.level)*10+'px'}"><span class="text-hover">{{item.name}}</span></td>
					<td align="right">{{item.currentDebitAmount|numFormat}}</td>
					<td align="right">{{item.currentCreditAmount|numFormat}}</td>
				</tr>
				<tr v-if="!dataList.length">
					<td colspan="4" class="text-center padding">暂无数据</td>
				</tr>
				</tbody>
			</table>
			<table class="balance" v-else>
				<thead class="header">
				<tr>
					<td rowspan="2" v-width="100">科目编码</td>
					<td rowspan="2" v-width="200">科目名称</td>
					<td rowspan="2" v-width="100">计量单位</td>
					<td colspan="2">金额合计</td>
					<td colspan="2">数量合计</td>
				</tr>
				<tr>
					<td>借方</td>
					<td>贷方</td>
					<td>借方</td>
					<td>贷方</td>
				</tr>
				</thead>
				<tbody>
				<tr v-for="item in dataList" :key="item.subjecId">
					<td :style="{'padding-left':(item.level)*10+'px'}">{{item.code}}</td>
					<td :style="{'padding-left':(item.level)*10+'px'}"><span class="text-hover">{{item.name}}</span></td>
					<td class="text-center">{{item.unit}}</td>
					<td align="right">{{item.currentDebitAmount|numFormat}}</td>
					<td align="right">{{item.currentCreditAmount|numFormat}}</td>
					<td align="right">{{item.currentDebitAmountNum|numFormat}}</td>
					<td align="right">{{item.currentCreditAmountNum|numFormat}}</td>
				</tr>
				<tr v-if="!dataList.length">
					<td colspan="7" class="text-center padding">暂无数据</td>
				</tr>
				</tbody>
			</table>
		</div>
	</app-content>
</template>

<script>

	export default {
		name: "SubjectSummary",
		data() {
			return {
				dataList: [],
				accountDate: null,
				showNumPrice: false,
				loading: false
			}
		},
		watch: {
			accountDate() {
				this.loadList();
			},
			showNumPrice() {
				this.loadList();
			}
		},
		methods: {
			loadList() {
				this.loading = true;
				this.$api.accountbook.loadSubjectSummary({
					accountDate: this.accountDate,
					showNumPrice: this.showNumPrice
				}).then(({data}) => {
					this.dataList = data;
				}).finally(() => {
					this.loading = false;
				})
			}
		}
	}
</script>

<style scoped lang="less">
	.balance {
		width: 100%;
		border-collapse: collapse;

		td {
			padding: 0 8px;
			border: 1px solid #e2e2e2;
			font-size: 12px;
			height: 32px;

			&.tip {
				background-color: #FFEEEF;
			}
		}

		tbody tr:nth-child(even) {
			background-color: #f8fbf8;
		}

		tbody tr:hover {
			background-color: #F0F6FF;
		}

		.header {
			td {
				background-color: #F5F5F5;
				text-align: center;
				font-weight: bold;
				height: 35px;
			}
		}
	}
</style>