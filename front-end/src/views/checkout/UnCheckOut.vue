<template>
	<div class="h-panel-body padding font-bold">
		<h3 class="margin text-center" v-if="!Object.keys(dataList).length">亲，目前没有已结账的期间！</h3>
		<template v-for="year in years">
			<h2 class="margin-bottom">{{year}}年</h2>
			<Row :space="20">
				<Cell v-for="month in dataList[year]" :key="year+month.checkMonth" width="3" v-if="month.status==2">
					<div class="period" :class="{disable:month.disable,completed:month.status==2}" @click="unCheck(month)">
						<div class="bg-primary-color month-header"></div>
						{{month.checkMonth}}月
					</div>
				</Cell>
			</Row>
		</template>
	</div>
</template>

<script>
	import {mapState} from "vuex";

  export default {
		name: "UnCheckOut",
		data() {
			return {
				dataList: {}
			}
		},
		computed: {
      ...mapState(['currentOrgId']),
			years() {
				return Object.keys(this.dataList).sort((a, b) => b - a);
			}
		},
		methods: {
			loadList() {
				this.$api.checkout.list({org_id:this.currentOrgId}).then(({data}) => {
					let checkData = {};
					data.forEach(val => {
						if (val.status == 2) {
							if (!checkData[val.checkYear]) {
								checkData[val.checkYear] = [];
							}
							checkData[val.checkYear].push(val);
						}
					});

					this.dataList = checkData;
				})
			},
			unCheck(data) {
				this.$Confirm("确定进行反结账 ?", "反结账操作").then(() => {
					this.$Loading("正在反结账中...");
					this.$api.checkout.unCheck({year: data.checkYear, month: data.checkMonth,orgId:this.currentOrgId}).then(() => {
						this.loadList();
					}).finally(() => {
						this.$Loading.close();
					});
				});
			}
		},
		mounted() {
			this.loadList();
		}
	}
</script>


<style lang="less" scoped>
	.h-row > div > div {
		padding: 8px;
		border-radius: 5px;
		text-align: center;
		font-size: 20px;
		color: #000;
	}

	.period {
		border-radius: 3px;
		text-align: center;
		line-height: 54px;
		border: 1px solid #929292;
		white-space: nowrap;
		overflow: hidden;
		box-sizing: border-box;
		height: 80px;

		&:hover {
			cursor: pointer;
			box-shadow: 0 0 20px 2px rgba(102, 100, 100, 0.24), 0px 2px 4px 0px rgba(199, 198, 198, 0.5);
		}

		.month-header {
			height: 25px;
			margin: -8px -8px 0 -8px;
		}

		&.completed {
			.month-header {
				background-color: #929292 !important;
				line-height: 20px;
			}

			color: #929292;
		}
	}
</style>
