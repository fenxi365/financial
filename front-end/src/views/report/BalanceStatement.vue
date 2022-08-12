<template>
  <app-content class="h-panel">
    <Loading text="数据加载中..." :loading="loading"></Loading>
    <div class="h-panel-bar">
      <span class="h-panel-title">资产负债表</span>
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
      <Cell>
        <Button :disabled="!report" :loading="loading" color="primary" @click="doSearch">查询</Button>
      </Cell>
    </Row>
    <div class="h-panel-body" v-if="report">
      <Table :datas="templateItemsRender" selectRow border>
        <TableItem title="资产">
          <div slot-scope="{data}" :class="{'font-bold':data.isBolder}" :style="{paddingLeft:((data.level-1)*15)+'px'}">{{data.title}}</div>
        </TableItem>
        <TableItem title="行次">
          <template slot-scope="{data}">
            {{data.isClassified ? '':data.lineNum>-1?data.lineNum:''}}
          </template>
        </TableItem>
        <TableItem title="期末余额" align="right">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].currentPeriodAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="年初余额" align="right">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].currentYearAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="负债和所有者权益">
          <div slot-scope="{data}" :class="{'font-bold':data.fs_isBolder}" :style="{paddingLeft:((data.fs_level-1)*15)+'px'}">{{data.fs_title}}</div>
        </TableItem>
        <TableItem title="行次">
          <template slot-scope="{data}">
            {{data.fs_isClassified ? '':data.fs_lineNum>-1?data.fs_lineNum:''}}
          </template>
        </TableItem>
        <TableItem title="期末余额" align="right">
          <template slot-scope="{data}">
            {{reportData[data.fs_id]?reportData[data.fs_id].currentPeriodAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="年初余额" align="right">
          <template slot-scope="{data}">
            {{reportData[data.fs_id]?reportData[data.fs_id].currentYearAmount:''|numFormat}}
          </template>
        </TableItem>
      </Table>
    </div>
  </app-content>
</template>

<script>
import {mapState} from 'vuex'

export default {
  name: "BalanceStatement",
  data() {
    return {
      orgOption: {
        keyName: 'id',
        parentName: 'parentId',
        titleName: 'title',
        dataMode: 'list',
        datas: []
      },
      report: null,
      reportData: {},
      accountDate: null,
      dataList: [],
      orgId: null,
      org: null,
      loading: false
    }
  },
  computed: {
    ...mapState(['User','orgDatas', 'currentOrgId']),
    templateItems() {
      return this.report ? this.report.items : [];
    },
    templateItemsRender() {
      if (this.report && this.templateItems) {
        //所有资产
        let zc = this.templateItems.filter(val => val.type === 0);
        let sq = this.templateItems.filter(val => val.type !== 0);
        sq.forEach((val, index) => {
          let changeObj = {
            fs_id: val.id,
            fs_lineNum: val.lineNum,
            fs_isBolder: val.isBolder,
            fs_level: val.level,
            fs_isClassified: val.isClassified,
            fs_title: val.title
          };
          if (zc[index]) {
            Object.assign(zc[index], changeObj);
          }
        });
        return zc;
      }
      return [];
    }
  },
  methods: {
    doSearch(){
      this.loadOrg();
    },
    loadReport() {
      if (this.org.debtTemplateId){
        Api.report.template.load(this.org.debtTemplateId).then(({data}) => {
          this.report = data;
          this.$nextTick(this.loadReportData);
        });
      } else {
        this.$Message.success('未授权资产负债表模板~')
      }
    },
    loadReportData() {
      if (this.accountDate){
        this.loading = true;
        Api.report.view(this.report.id, {accountDate: this.accountDate,orgId:this.orgId}).then(({data}) => {
          this.reportData = data;
        }).finally(() => this.loading = false);
      }
    },
    loadOrg() {
      this.$api.setting.organization.load(this.orgId).then(({data}) => {
        if (data){
          this.org = data;
          this.loadReport();
        }
      });
    },
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
    this.loadOrg();
  }
}
</script>

<style scoped>
div.font-bold {
  font-size: 14px;
}
</style>