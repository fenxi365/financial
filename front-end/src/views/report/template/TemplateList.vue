<template>
  <app-content class="h-panel">
    <div class="h-panel-bar"><span class="h-panel-title">报表模板</span>
      <div class="pull-right">
        <Button color="primary" @click="create()">添加</Button>
      </div>
    </div>
    <div class="h-panel-body">
      <Table :datas="dataList" :loading="loading">
        <TableItem prop="name" title="名称">
          <template slot-scope="{data}">
            <span class="h-tag h-tag-blue" style="margin-left: 10px;" v-if="data.isDefault">默认</span>
            <span class="h-tag h-tag-green" style="margin-left: 10px;" v-else>自建</span>
          </template>
        </TableItem>
        <TableItem prop="templateKey" title="标识"/>
        <TableItem prop="type" title="类型" dict="reportTemplateType"/>
        <TableItem prop="orgNames" title="授权机构" dict="orgNames"/>
        <TableItem title="操作" :width="230" align="center">
          <div class="actions" slot-scope="{data}">
<!--            <router-link :to="{name:'ReportView',params:{reportId:data.id}}" tag="span">预览</router-link>-->
            <router-link tag="span" :to="{name:'TemplateForm',params:{templateId:data.id}}">报表项目</router-link>
            <span @click="grant(data)" v-if="!data.isDefault">授权</span>
            <span @click="copy(data)">复制</span>
            <span v-if="!data.isDefault" @click="create(data)">编辑</span>
            <span v-if="!data.isDefault" @click="remove(data)">删除</span>
          </div>
        </TableItem>
      </Table>
    </div>
    <Modal v-model="templateModel" hasCloseIcon hasDivider :closeOnMask="false">
      <div slot="header">模板信息</div>
      <Form :labelWidth="60" ref="templateForm" :rules="validationRules" :model="form">
        <FormItem label="名称" prop="name">
          <input v-model="form.name" type="text">
        </FormItem>
        <FormItem label="标识" prop="templateKey">
          <input v-model="form.templateKey" type="text">
        </FormItem>
        <FormItem label="类型" prop="type">
          <Radio v-model="form.type" dict="reportTemplateType"></Radio>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button @click="templateModel=false" :width="800" :loading="loading">取消</Button>
        <Button color="primary" :loading="loading" @click="save()">添加</Button>
      </div>
    </Modal>
  </app-content>
</template>

<script>

export default {
  name: "TemplateList",
  data() {
    return {
      loading: false,
      templateModel: false,
      form: {
        id: null,
        name: '',
        templateKey: '',
        type: 0,
        isDefault: 0,
      },
      validationRules: {
        required: ['name', 'templateKey'],
        rules: {
          templateKey: {
            valid: {
              pattern: /^[a-z]+$/i,
              message: '只能为纯字母'
            }
          }
        }
      },
      dataList: [],
    }
  },
  methods: {
    loadList() {
      this.$api.report.template.list().then(({data}) => {
        this.dataList = data;
      });
    },
    copy(template){
      Object.assign(this.form, {copyId: template.id, copy: true,isDefault:0, name: template.name + "-副本"})
      this.templateModel = true;
    },
    grant(template) {
      this.$Modal({
        title: `授权组织`,
        closeOnMask: false,
        hasCloseIcon: true,
        width:600,
        component: {
          vue: (resolve) => require(['./GrantOrg.vue'], resolve),
          datas: {template}
        },
        events: {
          success: (mode) => {
            mode.close();
          }
        }
      });
    },
    save() {
      let validResult = this.$refs.templateForm.valid();
      if (validResult.result) {
        this.loading = true;
        this.$api.report.template.save(this.form).then(({data}) => {
          this.loadList();
        }).finally(() => {
          this.loading = false;
          this.templateModel = false;
        });
      }
    },
    create(data) {
      if (data) {
        this.form = data;
      } else {
        this.form = {
          id: null,
          name: '',
          templateKey: '',
          type: 0,
          isDefault: false,
        }
      }
      this.templateModel = true;
    },
    remove(data) {
      this.$Confirm("确认删除?").then(() => {
        this.$api.report.template.delete(data.id).then(() => {
          this.loadList();
        })
      })
    }
  },
  mounted() {
    this.loadList();
  }
}
</script>

<style scoped>

</style>