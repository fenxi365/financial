<template>
	<app-content class="h-panel">
		<div class="h-panel-bar">
			<span class="h-panel-title">
				<template v-if="auxiliary">{{auxiliary.name}}</template><template v-if="auxiliaryItem">:{{auxiliaryItem.name}}</template> 明细账</span>
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
		<Row class="h-panel-body" type="flex" :space-x="10">
			<Cell :flex="1">
				<Table :datas="dataList" :border="true" :loading="loading">
					<TableItem title="日期" prop="voucherDate" :width="85"></TableItem>
					<TableItem title="凭证字号" :width="85">
						<template slot-scope="{data}" v-if="data.word">
							<router-link :to="{name:'VoucherForm',params:{voucherId:data.voucherId}}">{{data.word}}-{{data.code}}</router-link>
						</template>
					</TableItem>
					<TableItem title="摘要" prop="summary"></TableItem>
					<TableItem title="借方" align="right" :width="85">
						<template slot-scope="{data}">
							{{data.debitAmount|numFormat}}
						</template>
					</TableItem>
					<TableItem title="贷方" align="right" :width="85">
						<template slot-scope="{data}">
							{{data.creditAmount|numFormat}}
						</template>
					</TableItem>
					<TableItem title="方向" prop="balanceDirection" align="center" :width="50"></TableItem>
					<TableItem title="余额" align="right" :width="85">
						<template slot-scope="{data}">
							{{data.balance|numFormat}}
						</template>
					</TableItem>
				</Table>
			</Cell>
			<Cell v-width="200">
				<Tree @select="doSelect" :option="param" ref="auxiliary" filterable selectOnClick className="h-tree-theme-row-selected"></Tree>
			</Cell>
		</Row>
	</app-content>
</template>

<script>
	import {mapState} from "vuex";

  export default {
		name: "AuxiliaryAccountingDetail",
		data() {
			return {
        orgOption: {
          keyName: 'id',
          parentName: 'parentId',
          titleName: 'title',
          dataMode: 'list',
          datas: []
        },
				dataList: [],
				loading: false,
				showNumPrice: false,
				param: {
					keyName: 'id',
					parentName: 'parentId',
					titleName: 'name',
					dataMode: 'list',
					datas: []
				},
				accountDate: null,
				orgId: null,
				auxiliary: null,
				auxiliaryItem: null,
				auxiliaryType: []
			}
		},
    computed: {
      ...mapState(['orgDatas', 'currentOrgId']),
    },
		methods: {
			loadAuxiliaryType() {
				this.$api.setting.accountingCategory.list().then(({data}) => {
					this.auxiliaryType = data;
				});
			},
			loadList() {
				this.loading = true;
				this.$api.accountbook.loadAuxiliaryDetails({
					accountDate: this.accountDate,
          orgId: this.orgId,
					auxiliaryId: this.auxiliary.id,
					auxiliaryItemId: this.auxiliaryItem.id,
				}).then(({data}) => {
					this.dataList = data;
				}).finally(() => {
					this.loading = false;
				});
			},
			loadAuxiliaryList() {
				this.dataList = [];
				this.$api.accountbook.loadAuxiliaryList({
					auxiliaryId: this.auxiliary.id,
          orgId: this.orgId
				}).then(({data}) => {
					data.forEach(val => val.name = val.code + " " + val.name);
					data = data.sort((a, b) => a.code.localeCompare(b.code));
					this.$set(this.param, "datas", data);
					if (data.length) {
						this.auxiliaryItem = data[0];
						this.loadList();
						this.$nextTick(() => {
							this.$refs.auxiliary.updateSelect(this.auxiliaryItem.id);
						});
					}
				});
			},
			doSearch() {
				this.loadAuxiliaryList();
			},
			doSelect(node) {
				this.auxiliaryItem = node;
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

<style scoped>

</style>