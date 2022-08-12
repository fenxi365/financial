<template>
  <app-content class="h-panel">
    <Loading text="数据加载中..." :loading="loading"></Loading>
    <div class="h-panel-bar">
      <span class="h-panel-title">多组织利润表</span>
    </div>
    <Row type="flex" :space-x="10" class="margin-right-left margin-top">
      <Cell>
        <Select :deletable="false" style="display: inline-block;min-width: 150px" filterable  type="Object" :datas="dataList" v-model="report"
                keyName="id" titleName="name"/>
      </Cell>
      <Cell>
        <account-date-choose v-model="accountDate"/>
      </Cell>
      <Cell>
        <Button :disabled="!report" :loading="loading" color="primary" @click="doSearch">查询</Button>
      </Cell>
    </Row>
    <div class="h-panel-body" v-if="report">
      <Table class="small-td" :datas="templateItems" selectRow border>
        <TableItem title="名称" :width="235">
          <div slot-scope="{data}" :class="{'font-bold':data.isBolder}" :style="{paddingLeft:((data.level-1)*15)+'px'}">{{data.title}}</div>
        </TableItem>
        <TableItem title="行次" :width="50" align="center">
          <template slot-scope="{data}">
            {{data.isClassified ? '':data.lineNum>-1?data.lineNum:''}}
          </template>
        </TableItem>
        <TableItem :title="org.name" :width="50" align="center" v-for="org in orgDatas" :key="org.id">
          <template slot-scope="{data}">
            {{reportData[data.id+'_'+org.id]?reportData[data.id+'_'+org.id].currentPeriodAmount:''|numFormat}}
          </template>
        </TableItem>
      </Table>
    </div>
  </app-content>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "OrgProfitStatement",
  data() {
    return {
      report: null,
      reportId: null,
      accountDate: null,
      reportData: {},
      dataList: [],
      loading: false
    }
  },
  computed: {
    ...mapState(['User','orgDatas', 'currentOrgId']),
    templateItems() {
      return this.report ? this.report.items : [];
    }
  },
  methods: {
    doSearch(){
      this.loadReportData();
    },
    loadReport() {
      if (this.report){
        Api.report.template.load(this.report.id).then(({data}) => {
          this.report = data;
          this.$nextTick(this.loadReportData);
        });
      }
    },
    loadReportData() {
      if (this.accountDate){
        this.loading = true;
        let datas={};
        this.orgDatas.forEach(o=>{
          Api.report.view(this.report.id, {accountDate: this.accountDate,orgId:o.id}).then(({data}) => {
            Object.keys(data).forEach((value) => {
              datas[value+'_'+o.id]=data[value];
            });
          }).finally(() => this.loading = false);
        })
        this.reportData =datas;
      }
    },
    loadList() {
      this.$api.report.template.list({type:0}).then(({data}) => {
        this.dataList = data;
        if (data.length){
          this.report = data[0];
          this.loadReport();
        }
      });
    },
  },
  mounted() {
    this.loadList();
  }
}
</script>

<style scoped>
div.font-bold {
  font-size: 14px;
}
</style>