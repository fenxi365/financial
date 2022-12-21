<template>
	<DropdownCustom ref="dropdownCustom" :toggleIcon="false" equalWidth>
		<div class="show-content">
			<span @click.stop="beforeDate"><i class="fa fa-caret-left"></i></span>
			<span>{{accountDate|fqFormat}}</span>
			<span @click.stop="afterDate"><i class="fa fa-caret-right"></i></span>
		</div>
		<div class="accountDateChoose" slot="content">
			<Row type="flex" v-if="years.length > 1">
				<Cell>
					<div class="text-hover" :class="{selected:selectedYear===y}" @click="selectedYear=y" v-for="y in years" :key="y" style="padding: 5px 10px;">{{y}}年</div>
				</Cell>
				<Cell :flex="1" class="split-line">
					<ul class="list-item" v-for="y in years" v-if="selectedYear===y">
						<li v-for="month in checkDateObject[y]" :key="y+month" @click="changVal(y,month)" :class="{'selected':selected(y+'-'+month)}">
							第{{month}}期
						</li>
					</ul>
				</Cell>
			</Row>
			<ul class="list-item" v-else>
				<li v-for="c in User.checkoutList" :key="c.id" @click="changVal(c.checkYear,c.checkMonth)" :class="{'selected':selected(c.checkYear+'-'+c.checkMonth)}">
					{{c.checkYear}}年第{{c.checkMonth}}期
				</li>
			</ul>
		</div>
	</DropdownCustom>
</template>

<script>
	import {mapState} from 'vuex'
	import moment from 'moment'

	export default {
		name: "AccountDateChoose",
		props: {
			value: [String],
		},
		computed: {
			...mapState(['currentAccountSets', 'User']),
			checkDateObject() {
				let data = {};
				this.User.checkoutList.forEach(item => {
					if (!data[item.checkYear]) {
						data[item.checkYear] = [];
					}
					data[item.checkYear].push(item.checkMonth);
				});
				Object.keys(data).forEach((value) => {
					data[value] = data[value].sort((a, b) => a - b);
				});
				return data;
			},
			years() {
				return Object.keys(this.checkDateObject).sort((a, b) => b - a);
			}
		},
		data() {
			return {
				selectedYear: null,
				accountDate: null
			}
		},
		watch: {
			accountDate(val) {
				this.$emit('input', val);
			},
			value(val) {
				this.accountDate = val;
			}
		},
		methods: {
			changVal(years, months) {
				this.accountDate = moment({years, months: months - 1, days: 1}).endOf('month').format('YYYY-MM-DD');
				this.$refs.dropdownCustom.hide();
			},
			selected(m) {
				return moment(this.accountDate).format('YYYY-M') === m;
			},
			beforeDate() {
				let d = moment(this.accountDate).add(-1, "M");
				let check = this.User.checkoutList[this.User.checkoutList.length - 1];
				let min = moment(check.checkYear + '-' + check.checkMonth).startOf('month');
				if (d.isSameOrAfter(min)) {
					this.accountDate = d.format('YYYY-MM-DD');
				}
			},
			afterDate() {
				let d = moment(this.accountDate).add(1, "M");
				let check = this.User.checkoutList[0];
				let min = moment(check.checkYear + '-' + check.checkMonth).endOf('month');
				if (d.isSameOrBefore(min)) {
					this.accountDate = d.format('YYYY-MM-DD');
				}
			},
		},
		mounted() {
			this.accountDate = this.currentAccountSets.currentAccountDate;
			this.selectedYear = this.years[0];
		}
	}
</script>

<style lang="less">
	.show-content {
		background: @primary-color;
		color: @white-color;
		cursor: pointer;
		border-radius: @border-radius;

		span {
			padding: 5px 10px;
			display: inline-block
		}
	}

	.accountDateChoose {
		overflow-y: auto;

		div.selected {
			border-bottom: 1px solid @primary-color;
			color: @primary-color;
			font-weight: bold;
		}

		.split-line {
			border-left: 1px solid @primary-color;
		}

		.list-item {
			li {
				padding: 5px 20px;

				&:hover {
					background-color: #F0F6FF;
					cursor: pointer;
				}

				&.selected {
					background: @primary-color;
					color: @white-color;
				}
			}
		}
	}
</style>