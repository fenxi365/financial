<template>
  <app-content class="h-panel">
    <div class="h-panel-bar"><span class="h-panel-title">凭证查询</span></div>
    <div class="margin-right-left margin-top">
      <account-date-choose v-model="accountDate"/>
      核算组织： <TreePicker :option="orgOption"  style="display: inline-block;min-width: 150px"
                  ref="orgTreePicker" v-model="orgId"></TreePicker>
      <div class="float-right">
        <template v-if="User.role!=='View' && currentAccountSets.voucherReviewed">
          <Button :loading="loading" @click="audit">审核</Button>
          <Button :loading="loading" @click="cancelAudit">取消审核</Button>
        </template>
        <DropdownMenu button @click="trigger" :datas="param">打印</DropdownMenu>
        <template v-if="User.role!=='View'">
          <Button :loading="loading" @click="finishingOffNo">整理断号</Button>
          <Button :loading="loading" @click="batchDelete">批量删除</Button>
          <Button :loading="loading" @click="doUpload">
            <input ref="file" type="file" accept="application/vnd.ms-excel" style="display: none"
                   @change="fileChange($event)">
            导入凭证
          </Button>
          <a :href="downloadUrl" class="h-btn">导出凭证</a>
        </template>
      </div>
    </div>
    <div class="h-panel-body">
      <table class="header">
        <tr>
          <th style="width: 50px"><input :checked="checkAll" type="checkbox" @click="checkAll=!checkAll"></th>
          <td style="width: 215px">摘要</td>
          <td>科目</td>
          <td align="right" style="width: 130px">借方金额</td>
          <td align="right" style="width: 130px">贷方金额</td>
        </tr>
      </table>
      <table v-if="!datas.length">
        <tr>
          <td colspan="5" class="text-center padding">暂无数据</td>
        </tr>
      </table>
      <table class="details" v-for="data in datas" :key="data.id">
        <tr class="details-header">
          <th style="width: 50px"><input :class="{'display':data._checked}" v-model="data._checked" type="checkbox">
          </th>
          <td colspan="2">日期：{{ data.voucherDate }} 凭证字号：{{ data.word }}-{{ data.code }}</td>
          <td colspan="2" class="actions" align="right">
            <router-link v-if="data.auditMemberId" tag="span" :to="{name:'VoucherForm',params:{voucherId:data.id}}">查看
            </router-link>
            <a :href="`/api/pfd/voucher?id=${data.id}`" target="_blank">打印</a>
            <router-link v-if="User.role!=='View'" tag="span" :to="{name:'VoucherForm',params:{voucherId:data.id}}">修改
            </router-link>
            <span v-if="User.role!=='View'" @click="remove(data)">删除</span>
            <i v-if="data.auditMemberId" class="h-icon-completed green-color" v-tooltip content="已审核"></i>
          </td>
        </tr>
        <tr v-for="d in data.details" :key="d.id">
          <th></th>
          <td style="width: 215px">
            {{ d.summary }}
            <template v-if="d.subject&&d.num&&d.price">
              (数量:{{ d.num }}<span class="dark4-color">{{ d.subject.unit }}</span>，单价:{{ d.price }}<span
                class="dark4-color">元</span>)
            </template>
          </td>
          <td>{{ d.subjectName }}</td>
          <td align="right" style="width: 130px">{{ d.debitAmount|numFormat }}</td>
          <td align="right" style="width: 130px">{{ d.creditAmount|numFormat }}</td>
        </tr>
        <tr class="font-bold">
          <td></td>
          <td>合计</td>
          <td>{{ data.debitAmount|dxMoney }}</td>
          <td align="right">{{ data.debitAmount|numFormat }}</td>
          <td align="right">{{ data.creditAmount|numFormat }}</td>
        </tr>
      </table>
      <Pagination v-model="pagination" @change="currentChange" layout="pager" small align="center"/>
    </div>
  </app-content>
</template>

<script>
import Qs from "qs";
import moment from 'moment'
import {mapState} from 'vuex'

export default {
  name: "Voucher",
  data() {
    return {
      orgOption: {
        keyName: 'id',
        parentName: 'parentId',
        titleName: 'title',
        dataMode: 'list',
        datas: []
      },
      accountDate: null,
      orgId: null,
      pagination: {
        page: 1,
        total: 0
      },
      loading: false,
      checkAll: false,
      param: [{title: '打印全部', key: 'printAll'}, {title: '打印选中', key: 'printCheck'}]
    };
  },
  watch: {
    checkAll(nval) {
      let data = Array.from(this.datas);
      data.forEach(val => val._checked = nval);
      this.datas = data;
    },
    accountDate() {
      this.pagination.page = 1;
      this.loadList();
    },
    orgId() {
      this.pagination.page = 1;
      this.loadList();
    }
  },
  computed: {
    ...mapState(['User', 'currentAccountSets', 'orgDatas', 'currentOrgId']),
    date() {
      return moment(this.accountDate);
    },
    downloadUrl() {
      return Ajax.PREFIX + "/voucher/download?orgId=" + this.orgId;
    },
  },
  methods: {
    loadOrg() {
      if (!this.orgId) {
        this.orgId = this.currentOrgId;
      }
      this.orgOption.datas = this.orgDatas.map(val => {
        return {id: val.id, name:val.name, type: val.type, title: `[${val.code}]${val.name}`, parentId: val.parentId,currentAccountDate:val.currentAccountDate,enableDate:val.enableDate}
      });
      this.$nextTick(() => {
        this.$refs.orgTreePicker.expandAll();
      });
    },
    currentChange() {
      this.loadList();
    },
    trigger(key) {
      this[key].call(this);
    },
    printAll() {
      let param = Qs.stringify({
        year: this.date.year(),
        month: this.date.month() + 1,
        orgId: this.orgId
      }, {indices: false});
      window.open(`/api/pfd/voucher?${param}`);
    },
    printCheck() {
      let checked = this.datas.filter(value => value._checked);
      if (checked.length) {
        let param = Qs.stringify({id: checked.map(value => value.id)}, {indices: false});
        window.open(`/api/pfd/voucher?${param}`);
      } else {
        this.$Message("未选择记录");
      }
    },
    loadList() {
      if (this.orgId) {
        this.loading = true;
        this.$api.voucher.list({
          voucher_year: this.date.year(),
          voucher_month: this.date.month() + 1,
          page: this.pagination.page,
          org_id: this.orgId
        }).then(({data}) => {
          this.datas = data.records;
          this.pagination = {
            page: data.current,
            size: data.size,
            total: data.total
          }
        }).finally(() => this.loading = false);
      }

    },
    remove(data) {
      this.$Confirm("确认删除?").then(() => {
        this.$api.voucher.delete(data.id).then(() => {
          this.loadList();
        })
      });
    },
    finishingOffNo() {
      this.loading = true;
      this.$api.voucher.finishingOffNo({
        year: this.date.year(),
        month: this.date.month() + 1,
        orgId: this.orgId
      }).then(() => {
        this.loadList();
      }).finally(() => {
        this.loading = false
      });
    },
    batchDelete() {
      let checked = this.datas.filter(value => value._checked);
      if (checked.length) {
        this.$Confirm("确认删除?").then(() => {
          this.loading = true;
          this.$api.voucher.batchDelete({
            checked: checked.map(value => value.id),
            orgId: this.orgId,
            year: this.date.year(),
            month: this.date.month() + 1
          }).then(() => {
            this.loadList();
          }).finally(() => {
            this.loading = false
          });
        });
      }
    },
    audit() {
      let checked = this.datas.filter(value => value._checked);
      if (checked.length) {
        this.$Confirm("亲，确认要审核吗?").then(() => {
          this.loading = true;
          this.$api.voucher.audit({
            checked: checked.map(value => value.id),
            orgId: this.orgId,
            year: this.date.year(),
            month: this.date.month() + 1
          }).then(() => {
            this.loadList();
            this.$Message("审核成功！");
          }).finally(() => {
            this.loading = false;
          });
        });
      } else {
        this.$Message("未选择记录");
      }
    },
    cancelAudit() {
      let checked = this.datas.filter(value => value._checked);
      if (checked.length) {
        this.$Confirm("亲，确认要取消审核吗?").then(() => {
          this.loading = true;
          this.$api.voucher.cancelAudit({
            checked: checked.map(value => value.id),
            orgId: this.orgId,
            year: this.date.year(),
            month: this.date.month() + 1
          }).then(() => {
            this.loadList();
            this.$Message("取消审核成功！");
          }).finally(() => {
            this.loading = false;
          });
        });
      } else {
        this.$Message("未选择记录");
      }
    },
    doUpload() {
      this.$refs.file.click();
    },
    fileChange(e) {
      if (this.$refs.file.files.length) {
        let formData = new FormData();
        formData.append('file', this.$refs.file.files[0]);
        formData.append('orgId', this.orgId);
        this.loading = true;
        this.$api.voucher.import(formData).then(({data}) => {
          if (data) {
            this.accountDate = data;
          }
          this.$store.dispatch('init');
          this.$Message("亲,导入成功~");
        }).finally(() => {
          this.loading = false;
        });

        this.$refs.file.value = "";
      }
    }
  },
  created() {
    this.loadOrg();
  }
};
</script>
<style lang='less' scoped>
.h-panel-body {
  table {
    width: 100%;
    border-collapse: collapse;

    td {
      padding: 7px;
    }

    &.header {
      background-color: @primary-color;
      color: white;
    }
  }

  .details {
    font-size: 12px;
    margin: 15px 0;
    border: 1px solid @gray2-color;

    .actions {
      text-align: right;
      padding-right: 20px;

      span, a {
        display: none;
      }
    }

    input {
      display: none;

      &.display {
        display: inline-block;
      }
    }

    &-header {
      background-color: @gray3-color;
      color: @dark3-color;
    }

    td, th {
      border-bottom: 1px solid @gray2-color;
    }

    tr:hover:not(.details-header) {
      background-color: #dff7df;
      cursor: pointer;
    }

    &:hover {
      box-shadow: 0 0 10px 0 #dadada;
      border-color: #dadada;

      .actions {
        span, a {
          display: inline-block;
        }
      }

      input {
        display: inline-block;
      }
    }
  }
}
</style>