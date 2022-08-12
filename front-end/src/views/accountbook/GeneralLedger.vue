<template>
	<app-content class="h-panel">
		<div class="h-panel-bar">
			<span class="h-panel-title">总账</span>
		</div>
		<div class="margin-right-left margin-top">
			<account-date-choose v-model="accountDate"/>
      核算组织：
      <TreePicker :option="orgOption"  style="display: inline-block;min-width: 150px"
                  ref="orgTreePicker" v-model="orgId"></TreePicker>
			<div class="float-right">
				<Checkbox v-model="showNumPrice">显示数量金额</Checkbox>
			</div>
		</div>
		<div class="h-panel-body margin" :space-x="10" style="overflow-x: auto;padding: 0;">
			<Loading text="总账数据加载中..." :loading="loading"></Loading>
			<table class="summary" v-if="!showNumPrice">
				<tr class="header bg-primary-color white-color">
					<td>科目编码</td>
					<td>科目名称</td>
					<td>期间</td>
					<td>摘要</td>
					<td>借方金额</td>
					<td>贷方金额</td>
					<td>方向</td>
					<td>余额</td>
				</tr>
				<template v-for="item in datalist">
					<tr class="bg-gray3-color">
						<td colspan="8">
							<span @click="toggleSummary(item)" class="text-hover">
								<i class="fa fa-caret-down" :class="{'fa-caret-right':item._expand}"></i>
								<span class="primary-color font-bold"> {{item.subject.name}}</span>
							</span>
						</td>
					</tr>
					<tr v-if="!item._expand" class="summary" v-for="s in item.summary">
						<td>{{item.subject.code}}</td>
						<td>{{item.subject.name}}</td>
						<td>{{s.voucherDate|fqFormat}}</td>
						<td>{{s.summary}}</td>
						<td align="right">{{s.debitAmount}}</td>
						<td align="right">{{s.creditAmount}}</td>
						<td align="center">{{s.balanceDirection}}</td>
						<td align="right">{{s.balance}}</td>
					</tr>
				</template>
				<tr v-if="!datalist.length">
					<td colspan="8" class="text-center padding">暂无数据</td>
				</tr>
			</table>
			<table v-else class="cus-table" style="width: 1780px;">
				<thead class="header">
				<tr>
					<td rowspan="2" width="100">科目编码</td>
					<td rowspan="2" width="100">科目名称</td>
					<td rowspan="2" width="80">单位</td>
					<td colspan="4">期初余额</td>
					<td colspan="2">本期借方</td>
					<td colspan="2">本期贷方</td>
					<td colspan="2">本年累计借方</td>
					<td colspan="2">本年累计贷方</td>
					<td colspan="4">期末余额</td>
				</tr>
				<tr>
					<td width="100">方向</td>
					<td width="100">数量</td>
					<td width="100">单价</td>
					<td width="100">金额</td>
					<td width="100">数量</td>
					<td width="100">金额</td>
					<td width="100">数量</td>
					<td width="100">金额</td>
					<td width="100">数量</td>
					<td width="100">金额</td>
					<td width="100">数量</td>
					<td width="100">金额</td>
					<td width="100">方向</td>
					<td width="100">数量</td>
					<td width="100">单价</td>
					<td width="100">金额</td>
				</tr>
				</thead>
				<tr v-for="{subject,summary} in datalist" :key="subject.id">
					<td>{{subject.code}}</td>
					<td>{{subject.name}}</td>
					<td class="text-center">{{subject.unit}}</td>
					<td class="text-center">{{summary[0].balanceDirection}}</td>
					<td class="text-right">{{summary[0].num}}</td>
					<td class="text-right">{{summary[0].price|numFormat}}</td>
					<td class="text-right">{{summary[0].balance|numFormat}}</td>
					<td class="text-right">{{summary[1].debitAmount ? summary[1].num:''}}</td>
					<td class="text-right">{{summary[1].debitAmount|numFormat}}</td>
					<td class="text-right">{{summary[1].creditAmount ? summary[1].num:''}}</td>
					<td class="text-right">{{summary[1].creditAmount|numFormat}}</td>
					<td class="text-right">{{summary[2].debitAmount ? summary[2].num:''}}</td>
					<td class="text-right">{{summary[2].debitAmount|numFormat}}</td>
					<td class="text-right">{{summary[2].creditAmount ? summary[2].num:''}}</td>
					<td class="text-right">{{summary[2].creditAmount|numFormat}}</td>
					<td class="text-center">{{summary[1].balanceDirection}}</td>
					<td class="text-right">{{summary[1].num}}</td>
					<td class="text-right">{{summary[1].price|numFormat}}</td>
					<td class="text-right">{{summary[1].balance|numFormat}}</td>
				</tr>
			</table>
		</div>
	</app-content>
</template>

<script>
	import {mapState} from "vuex";

  export default {
		name: 'GeneralLedger',
    computed: {
      ...mapState(['orgDatas', 'currentOrgId']),
    },
		data() {
			return {
        orgOption: {
          keyName: 'id',
          parentName: 'parentId',
          titleName: 'title',
          dataMode: 'list',
          datas: []
        },
				loading: false,
				accountDate: null,
        orgId: null,
				showNumPrice: false,
				numPriceDisabled: true,
				datalist: []
			};
		},
		watch: {
			accountDate() {
				this.loadList();
			},
			showNumPrice() {
				this.loadList();
			},
      orgId() {
				this.loadList();
			}
		},
		methods: {
			loadList() {
			  if (this.accountDate && this.orgId){
          this.loading = true;
          this.$api.accountbook.loadGeneralLedger({
            accountDate: this.accountDate,
            orgId: this.orgId,
            showNumPrice: this.showNumPrice
          }).then(({data}) => {
            this.datalist = data;
            this.loading = false;
          });
        }
			},
			toggleSummary(item) {
				this.$set(item, '_expand', !item._expand)
			}
		},
    created() {
		  if (this.currentOrgId){
		    this.orgId = this.currentOrgId;
      }
      this.orgOption.datas = this.orgDatas.map(val => {
        return {id: val.id, name:val.name, type: val.type, title: `[${val.code}]${val.name}`, parentId: val.parentId,currentAccountDate:val.currentAccountDate,enableDate:val.enableDate}
      });
      this.$nextTick(() => {
        this.$refs.orgTreePicker.expandAll();
      });
    }
  };
</script>

<style scoped lang="less">
	.summary {
		width: 100%;
		border-collapse: collapse;

		td {
			padding: 0 8px;
			border: 1px solid #eee;
			font-size: 12px;
			height: 32px;
		}

		.summary:nth-child(even) {
			background-color: #f8fbf8;
		}

		.summary:hover {
			background-color: #dff7df;
		}


		.header {
			td {
				text-align: center;
				font-weight: bold;
				height: 35px;
			}
		}
	}
</style>
