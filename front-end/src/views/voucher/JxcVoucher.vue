<template>
  <app-content class="h-panel">
    <template v-if="chekSetting">
      <Row type="flex" :space-x="10" class="margin-right-left padding-top">
        <Cell :flex="1">
          <div class="h-input-group" v-width="350">
            <DatePicker v-model="params.start" style="width: 140px" :clearable="false" :option="{end:params.end}"
                        format="YYYY-MM-dd"></DatePicker>
            <span class="h-input-addon">至</span>
            <DatePicker v-model="params.end" style="width: 140px" :clearable="false" :option="{start:params.start}"
                        format="YYYY-MM-dd"></DatePicker>
          </div>
        </Cell>
        <Cell>
          <Button color="primary" icon="fa fa-search" :loading="loading" @click="doSearch">查询</Button>
          <Button :disabled="checkedRecords.length===0" color="red" @click="generateVoucherPreview"
                  icon="h-icon-success" :loading="loading">生成凭证
          </Button>
        </Cell>
      </Row>
      <div class="h-panel-body">
        <Row type="flex" :space-x="8" style="flex-wrap: nowrap">
          <Cell :flex="1">
            <div style="height:calc(100vh - 230px);">
              <vxe-table :loading="loading"
                         ref="xTable"
                         size="mini"
                         height="auto"
                         show-overflow
                         @checkbox-change="onChecked"
                         @checkbox-all="onChecked"
                         :data="dataList"
                         highlight-hover-row>
                <vxe-table-column type="checkbox" width="40" align="center" fixed="left"/>
                <vxe-table-column type="seq" width="60" align="center" title="序号"/>
                <vxe-table-column title="单号" field="code" show-overflow :width="180"/>
                <vxe-table-column title="单据日期" field="billDate" width="120"/>
                <vxe-table-column title="供货商ID" field="supplierId"/>
                <vxe-table-column title="供货商" field="supplierName"/>
                <vxe-table-column title="单据金额" field="amount" :width="100" align="right"/>
              </vxe-table>
            </div>
            <Pagination style="margin-top: 10px;" v-model="pagination" layout="total,sizes,pager,jumper"
                        @change="currentChange" small align="right"/>
          </Cell>
          <Cell v-width="170" style="border: 1px solid #F5F5F5">
            <ListView :datas="rightData" v-model="currentType"></ListView>
          </Cell>
        </Row>
      </div>
    </template>
    <div class="form" v-else>
      <div class="text-center font-bold padding">请先去[设置]->[关联进销存]进行配置...</div>
      <Button @click="toSetting" color="red" block>去设置</Button>
    </div>
  </app-content>
</template>

<script>
import ListView from "@/components/ListView";
import manba from "manba";
import {mapState} from "vuex";
//0 期初入库 ，1 验收入库单，2 验收退货单，3 报损出库单，5部门调拨单 6 销售扣减单 7,外销单，8 盘点单 9 门店加工单 ，10 门店调拨入库单，11 门店调拨出库单
export default {
  name: "JxcVoucher",
  components: {ListView},
  data() {
    return {
      params: {
        start: manba().startOf(manba.MONTH).format(),
        end: manba().endOf(manba.MONTH).format(),
      },
      loading: false,
      dataList: [],
      checkedRecords: [],
      rightData: [
        {name: '期初入库', id: 0},
        {name: '验收入库单', id: 1},
        {name: '验收退货单', id: 2},
        {name: '报损出库单', id: 3},
        {name: '部门调拨单', id: 5},
        {name: '销售扣减单', id: 6},
        {name: '外销单', id: 7},
        {name: '盘点单', id: 8},
        {name: '门店加工单', id: 9},
        {name: '门店调拨入库单', id: 10},
        {name: '门店调拨出库单', id: 11},
      ],
      currentType: null,
      pagination: {
        page: 1,
        size: 20,
        total: 0
      },
    }
  },
  computed: {
    ...mapState(["currentAccountSets", 'currentOrg']),
    queryParams() {
      return Object.assign(this.params, {
        page: this.pagination.page,
        pageSize: this.pagination.size,
        type: this.type,
      })
    },
    chekSetting() {
      if (this.currentAccountSets.token && this.currentOrg.entityId) {
        return true;
      }
      return false;
    },
    type() {
      if (this.currentType) {
        return this.currentType.id;
      }
      return null;
    }
  },
  watch: {
    'currentType'() {
      this.pagination.page = 1;
      this.loadList();
    }
  },
  methods: {
    doSearch() {
      this.pagination.page = 1;
      this.loadList();
    },
    onChecked({records}) {
      this.checkedRecords = records.filter(val => Number(val.amount) !== 0);
    },
    loadList() {
      this.$api.setting.Inventory.order(this.queryParams).then(({data}) => {
        this.dataList = data.results || [];
        this.pagination.total = data.total;
      })
    },
    currentChange() {
      this.loadList();
    },
    generateVoucherPreview() {
      this.$Modal({
        title: `创建预览凭证`,
        closeOnMask: false,
        hasDivider: true,
        hasCloseIcon: false,
        middle: true,
        component: {
          vue: (resolve) => {
            require(['./JXCGenerateVoucherPreview'], resolve);
          },
          datas: {
            type: this.type,
            records: this.checkedRecords,
          }
        }
      });
    },
    toSetting(){
      this.$router.push({name: 'JxcSetting'});
    },
  },
  created() {
    if (this.chekSetting) {
      this.currentType = this.rightData[0];
      this.loadList();
    }
  }
}
</script>

<style scoped lang="less">
.form {
  border: @border;
  margin: 30px auto;
  padding: 30px;
  width: 800px;
}
</style>
