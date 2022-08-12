<template>
  <app-content class="h-panel">
    <div class="padding-right-left padding-top">
      <span class="dark4-color">*提示：组织机构</span>
      <div class="pull-right">
<!--        <Button @click="create()" color="primary">新增</Button>-->
      </div>
    </div>
    <div class="h-panel-body padding">
      <vxe-table border show-overflow size="mini" :tree-config="{expandAll: true,transform: true, rowField: 'id', parentField: 'parentId'}" :data="datas">
        <vxe-column field="code" title="编码" tree-node/>
        <vxe-column field="name" title="名称"/>
        <vxe-column title="当前记账年月" field="currentAccountDate" :width="120" :format="dateFormat"></vxe-column>
        <vxe-column title="启用年月" field="enableDate" :width="120" :format="dateFormat"></vxe-column>
        <vxe-column title="类型">
          <template #default="{row}">
            <span v-if="row.type===0">总公司</span>
            <span v-else-if="row.type===1">门店</span>
            <span v-else>部门</span>
          </template>
        </vxe-column>
        <vxe-column field="linkman" title="联系人"/>
        <vxe-column field="telephone" title="联系电话"/>
        <vxe-column field="status" title="状态">
          <template #default="{row:{status}}">
            <span>{{ status ? "正常" : "禁用" }}</span>
          </template>
        </vxe-column>
        <vxe-column title="操作">
          <template #default="{row}">
            <span class="actions">
              <span @click="create(row)" v-if="row.type !== 2">新增</span>
              <span @click="edit(row)">编辑</span>
<!--              <span @click="remove(row)">删除</span>-->
            </span>
          </template>
        </vxe-column>
      </vxe-table>
    </div>
    <Modal v-model="showForm" type="drawer-right" hasCloseIcon>
      <div slot="header">新增</div>
      <Form ref="form" v-width="800" mode="twocolumn" :labelWidth="150" :model="form" :rules="validationRules">
        <FormItem label="编码" prop="code">
          <input type="text" v-model="form.code">
        </FormItem>
        <FormItem label="名称" prop="name">
          <input type="text" v-model="form.name">
        </FormItem>
        <FormItem label="启用年月" prop="enableDate">
          <DatePicker type="month" v-model="form.enableDate" :disabled="used"/>
        </FormItem>
        <FormItem label="类型" prop="type">
          <Radio type="text" v-model="form.type" dict="organizationType" v-if="!form.parentId"/>
          <Radio type="text" v-model="form.type" :datas="[{key:1,title:'门店'},{key:2,title:'部门'}]" v-else/>
        </FormItem>
        <FormItem label="联系人" prop="linkman">
          <input type="text" v-model="form.linkman">
        </FormItem>
        <FormItem label="联系电话" prop="telephone">
          <input type="text" v-model="form.telephone">
        </FormItem>
        <FormItem label="状态">
          <Radio v-model="form.status" dict="statusRadios"></Radio>
        </FormItem>
      </Form>
      <div class="text-center">
        <Button @click="showForm=false">取消</Button>
        <Button color="green" @click="submit" :loading="loading">{{ form.id ? '保存' : '保存' }}</Button>
      </div>
    </Modal>
  </app-content>
</template>

<script>

import {mapState} from 'vuex';
import moment from "moment";

const emptyForm = {
  "id": null,
  "code": "",
  "name": "",
  "type": 0,
  "linkman": "",
  "telephone": "",
  "enableDate": null,
  "parentId": null,
  "accountSetsId": null,
  "status": true
};

export default {
  name: "Organization",
  data() {
    return {
      datas: [],
      validationRules: {
        required: ["code", "name", "enableDate"]
      },
      unit: null,
      parent: null,
      used: false,
      showForm: false,
      loading: false,
      form: HeyUtils.copy(emptyForm)
    };
  },
  computed: {
    ...mapState(['currentAccountSets']),
    parentSubject() {
      return this.parent ? this.parent.name : '';
    },
  },
  watch: {
    type() {
      this.loadList()
    },
    showForm(val) {
      if (!val) {
        this.parent = null;
        this.form = HeyUtils.copy(emptyForm);
      }
    },
  },
  methods: {
    dateFormat(val) {
      return val ? moment(val).format("YYYY年MM月") : '';
    },
    loadList() {
      this.loading = true;
      this.$api.setting.organization.list().then(({data}) => {
        this.datas = Object.freeze(data) || [];
        this.loading = false
      });
    },
    submit() {
      let validResult = this.$refs.form.valid();
      if (validResult.result) {
        this.loading = true;
        this.form.enableDate = moment(this.form.enableDate).format("YYYY-MM-DD");
        this.$api.setting.organization[this.form.id ? 'update' : 'save'](Object.assign(this.form)).then(() => {
          this.loadList();
          this.$store.dispatch('init');
          this.showForm = false;
          this.loading = false;
        }).catch(() => {
          this.loading = false;
        })
      }
    },
    create(data) {
      if (data) {
        this.form = HeyUtils.copy(emptyForm);
        this.form.parentId = data.id;
        if (data.type===0){
          this.form.type = 1;
        }else {
          this.form.type = 2;
        }
      }
      this.showForm = true;
    },
    remove(data) {
      this.$Confirm("确认删除?").then(() => {
        this.$api.setting.organization.delete(data.id).then(() => {
          this.loadList(true);
          this.$store.dispatch('init');
        })
      })
    },
    edit(row) {
      Api.setting.organization.checkUse(row.id).then(({data}) => {
        this.used = data;
        this.form = HeyUtils.copy(row);
        this.showForm = true;
      })
    },
  },
  mounted() {
    this.loadList();
  }
};
</script>

<style scoped>
div.h-tabs.h-tabs-card {
  border-bottom: 1px solid #52abc50d;
}

div.h-panel-body {
  padding-top: 0px;
}

div.h-panel-bar {
  border-bottom: 0px solid #eeeeee;
  border-top: 1px solid #eeeeee;
}

</style>
