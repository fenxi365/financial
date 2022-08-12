<template>
	<app-content class="h-panel">
		<div class="h-panel-bar">
			<span class="h-panel-title"><template v-if="auxiliary">{{auxiliary.name}} -</template> 核算项目余额</span>
		</div>
		<Row type="flex" :space-x="10" class="margin-right-left margin-top">
			<Cell>
				<account-date-choose v-model="accountDate"/>
			</Cell>
			<Cell class="label">核算组织：</Cell>
			<Cell>
        <TreePicker :option="orgOption"  style="display: inline-block;min-width: 150px"
                    ref="orgTreePicker" v-model="orgId"></TreePicker>
      </Cell>
      <Cell class="label">辅助类别：</Cell>
			<Cell>
				<Select type="object" v-model="auxiliary" :deletable="false" style="min-width: 100px" :datas="auxiliaryType" keyName="id" titleName="name"/>
			</Cell>
			<Cell>
				<Button :disabled="!auxiliary" :loading="loading" color="primary" @click="doSearch">查询</Button>
			</Cell>
			<Cell :flex="1">
				<!--<div class="float-right">
					<Checkbox v-model="showNumPrice">显示数量金额</Checkbox>
				</div>-->
			</Cell>
		</Row>
		<div class="h-panel-body">
			<table class="balance" v-if="auxiliary">
				<thead class="header">
				<tr>
					<td rowspan="2">{{auxiliary.name}}编码</td>
					<td rowspan="2">{{auxiliary.name}}名称</td>
					<td colspan="2">期初余额</td>
					<td colspan="2">本期发生额</td>
					<td colspan="2">期末余额</td>
				</tr>
				<tr>
					<td>借方</td>
					<td>贷方</td>
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
					<td>{{item.beginningDebitBalance|numFormat}}</td>
					<td>{{item.beginningCreditBalance|numFormat}}</td>
					<td>{{item.currentDebitAmount|numFormat}}</td>
					<td>{{item.currentCreditAmount|numFormat}}</td>
					<td :class="{tip:item.endingDebitBalance<0}">{{item.endingDebitBalance|numFormat}}</td>
					<td :class="{tip:item.currentCreditAmount<0}">{{item.endingCreditBalance|numFormat}}</td>
				</tr>
				<tr v-if="!dataList.length">
					<td colspan="8" class="text-center padding">暂无数据</td>
				</tr>
				</tbody>
			</table>
		</div>
	</app-content>
</template>

<script>
	import {mapState} from "vuex";

  export default {
		name: "AuxiliaryAccountingBalance",
		data() {
			return {
				dataList: [],
        orgOption: {
          keyName: 'id',
          parentName: 'parentId',
          titleName: 'title',
          dataMode: 'list',
          datas: []
        },
				showNumPrice: false,
				loading: false,
				accountDate: null,
				orgId: null,
				auxiliary: null,
				auxiliaryItem: {},
				auxiliaryType: [],
				auxiliaryList: []
			}
		},
    computed: {
      ...mapState(['orgDatas', 'currentOrgId']),
    },
		methods: {
			loadAuxiliaryType() {
				this.$api.setting.accountingCategory.list().then(({data}) => {
					this.auxiliaryType = data;
					if (data.length) {
						this.auxiliary = data[0];
					}
				});
			},
			loadList() {
				if (this.auxiliary) {
					this.loading = true;
					this.$api.accountbook.loadAuxiliaryBalance({
						accountDate: this.accountDate,
            orgId: this.orgId,
						auxiliaryId: this.auxiliary.id
					}).then(({data}) => {
						this.dataList = data;
					}).finally(() => {
						this.loading = false;
					});
				}

			},
			doSearch() {
				this.loadList();
			}
		},
		mounted() {
      if (this.currentOrgId) {
        this.orgId = this.currentOrgId;
      }
      this.orgOption.datas = this.orgDatas.map(val => {
        return {id: val.id, name:val.name, type: val.type, title: `[${val.code}]${val.name}`, parentId: val.parentId,currentAccountDate:val.currentAccountDate,enableDate:val.enableDate}
      });
      this.$nextTick(() => {
        this.$refs.orgTreePicker.expandAll();
      });
			this.loadAuxiliaryType();
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
			height: 35px;

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
			}
		}
	}
</style>