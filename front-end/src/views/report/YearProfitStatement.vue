<template>
  <app-content class="h-panel">
    <Loading text="数据加载中..." :loading="loading"></Loading>
    <div class="h-panel-bar">
      <span class="h-panel-title">年度利润表</span>
    </div>
    <Row type="flex" :space-x="10" class="margin-right-left margin-top">
      <Cell>
        <DatePicker v-model="year" :clearable="false" type="year"></DatePicker>
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
      <Table class="small-td" :datas="templateItems" selectRow border>
        <TableItem title="名称" :width="235">
          <div slot-scope="{data}" :class="{'font-bold':data.isBolder}" :style="{paddingLeft:((data.level-1)*15)+'px'}">{{data.title}}</div>
        </TableItem>
        <TableItem title="行次" :width="30" align="center">
          <template slot-scope="{data}">
            {{data.isClassified ? '':data.lineNum>-1?data.lineNum:''}}
          </template>
        </TableItem>
        <TableItem title="一月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].januaryAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="二月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].februaryAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="三月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].marchAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="四月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].aprilAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="五月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].mayAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="六月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].juneAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="七月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].julyAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="八月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].augustAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="九月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].septemberAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="十月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].octoberAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="十一月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].novemberAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="十二月" align="center" :width="80">
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].decemberAmount:''|numFormat}}
          </template>
        </TableItem>
        <TableItem title="合计累计金额" align="right" :width="100" >
          <template slot-scope="{data}">
            {{reportData[data.id]?reportData[data.id].currentYearAmount:''|numFormat}}
          </template>
        </TableItem>
      </Table>
    </div>
  </app-content>
</template>

<script>
import {mapState} from 'vuex'
import manba from 'manba';
export default {
  name: "YearProfitStatement",
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
      year: manba().format("YYYY"),
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
    }
  },
  methods: {
    doSearch(){
      this.loadOrg();
    },
    loadReport() {
      if (this.org && this.org.profitTemplateId) {
        Api.report.template.load(this.org.profitTemplateId).then(({data}) => {
          this.report = data;
          this.$nextTick(this.loadReportData);
        });
      } else {
        this.loading = false
        this.$Message.success('未授权利润表模板~')
      }
    },
    loadReportData() {
      if (this.year){
        this.loading = true;
        Api.report.yearProfit(this.report.id, {year: this.year,orgId:this.orgId}).then(({data}) => {
          this.reportData = data;
        }).finally(() => this.loading = false);
      }
    },
    loadOrg() {
      this.loading = true;
      this.$api.setting.organization.load(this.orgId).then(({data}) => {
        if (data) {
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