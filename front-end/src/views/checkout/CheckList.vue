<template>
	<div class="h-panel-body padding font-bold">
		<template v-for="year in years">
			<h2 class="margin-bottom">{{year}}年</h2>
			<Row :space="20">
				<Cell v-for="month in dataList[year]" :key="year+month.checkMonth" width="3">
					<div class="period" :class="{disable:month.disable,completed:month.status==2}" @click="carryForward(month)">
						<div class="bg-primary-color month-header">
							<i v-if="month.status==2" class="fa fa-lock white-color"></i>
						</div>
						{{month.checkMonth}}月
					</div>
				</Cell>
			</Row>
		</template>
	</div>
</template>

<script>
	export default {
		name: "CheckList",
		data() {
			return {
				dataList: {}
			}
		},
		computed: {
			years() {
				return Object.keys(this.dataList).sort((a, b) => b - a);
			}
		},
		methods: {
			loadList() {
				this.$api.checkout.list().then(({data}) => {
					let disable = false;
					for (let i = data.length - 1; i >= 0; i--) {
						data[i].disable = disable;

						if (data[i].status === 0) {
							disable = true;
						}
					}

					let checkData = {};
					data.forEach(val => {
						if (!checkData[val.checkYear]) {
							checkData[val.checkYear] = [];
						}
						checkData[val.checkYear].push(val);
					});

					this.dataList = checkData;
				})
			},
			carryForward(data) {
				if (data.status === 0 && !data.disable) {
					this.$router.push({name: 'CarryForward', params: data})
				} else if (data.disable) {
					this.$Message("上期未结转损益，本期不能点击")
				}
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
		border: 1px solid @primary-color;
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
				background-color: @gray1-color !important;
				line-height: 20px;
			}

			border-color: @gray1-color;

			color: #a2a2a2;

			&:hover {
				cursor: default;
				box-shadow: none;
			}
		}

		&.disable {
			opacity: 0.4;

			&:hover {
				cursor: default;
				box-shadow: none;
			}
		}
	}
</style>
