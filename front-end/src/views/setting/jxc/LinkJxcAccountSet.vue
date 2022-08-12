<template>
  <div class="h-panel-body padding">
    <vxe-table border show-overflow size="mini" :data="datas">
      <vxe-column field="state" title="关联状态" width="100"/>
      <vxe-column field="companyName" title="财务软件账套"/>
      <vxe-column field="jxc" title="进销存账套"/>
      <vxe-column title="操作" width="200">
        <template #default="{row}">
            <span class="actions">
              <span @click="edit(row)">编辑</span>
            </span>
        </template>
        <template #default="{row}">
            <span class="actions">
              <span @click="edit(row)">关联门店</span>
            </span>
        </template>
      </vxe-column>
    </vxe-table>
  </div>
<!--  <Modal v-model="showForm" type="drawer-right" hasCloseIcon>-->
<!--    <div slot="header">进销存软件授权</div>-->
<!--    <Form ref="form" v-width="800"  :labelWidth="150"  ref="loginForm" :model="loginForm" :rules="loginValidationRules">-->
<!--            <FormItem label="账号" prop="username">-->
<!--              <input type="text" v-model="loginForm.username">-->
<!--            </FormItem>-->
<!--            <FormItem label="密码" prop="password">-->
<!--              <input type="password" v-model="loginForm.password">-->
<!--            </FormItem>-->
<!--          </Form>-->
<!--          <div class="text-center">-->
<!--            <Button @click="showForm=false">取消</Button>-->
<!--            <Button color="green" @click="loginSubmit" :loading="loading">保存</Button>-->
<!--          </div>-->
<!--        </Modal>-->
<!--  <Modal v-model="showForm" type="drawer-right" hasCloseIcon>-->
<!--        <div class="text-center font-bold padding">关联进销存门店</div>-->
<!--        <div class="h-input-group" v-for="org in orgList" style="margin-bottom: 10px;">-->
<!--          <span class="sys-border" style="width: 300px">[{{ org.code }}]{{ org.name }}</span>-->
<!--          <span class="h-input-addon">-</span>-->
<!--          <Select v-model="org.entityId" filterable :datas="storeList" keyName="id" titleName="name">-->
<!--            <template slot="item" slot-scope="{item}">[{{ item.code }}]{{ item.name }}</template>-->
<!--            <template slot="show" slot-scope="{value}">[{{ value.code }}]{{ value.name }}</template>-->
<!--          </Select>-->
<!--        </div>-->
<!--  </Modal>-->
</template>

<script>
import {mapState} from "vuex";

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/13 15:13</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
export default {
  name: "LinkJxcAccountSet",
  data() {
    return {
      datas: [],
      loading: false,
      isLogin: false,
      storeList: [],
      orgList: [],
      loginForm: {
        username: 10011,
        password: 781004,
      },
      loginValidationRules: {
        required: ['username', 'password']
      },
    }
  },
  computed: {
    ...mapState(["currentAccountSets", 'orgDatas'])
  },
  methods: {
    loginSubmit(){
      let validResult = this.$refs.loginForm.valid();
      if (validResult.result) {
        this.loading = true;
        this.$api.setting.inventory.login(this.loginForm).then((res) => {
          if (res.msg){
            this.initOrganization();
          }
        }).finally(() => this.loading = true);
      }
    },
    initOrganization(){
      this.$api.setting.Inventory.org().then(({data}) => {
        if (data){
          this.storeList = data;
          data.forEach(row => {
            let st =  this.orgList.find(val => val.name.indexOf(row.name) !== -1);
            if (st && !st.entityId) {
              st.entityId = row.id;
            }
          });
        }
        this.isLogin = true;
      })
    },
    saveOrgMapping() {
      this.loading = true;
      this.$api.setting.organization.mapping(this.orgList).then(({data}) => {
        this.$Message('映射成功~');
        this.$store.dispatch('init');
        this.step = 2;
      }).finally(() => this.loading = false);
    },
    loadList() {
      this.$api.setting.accountSets.list().then(({data}) => {
        this.datas = data || [];
      })
    },
  },
  created() {
    this.loadList();
    this.orgList = this.orgDatas;
    if (this.currentAccountSets.token) {
      this.initOrganization();
    }
  }
}
</script>


<style scoped lang="less">
.box {
  .form {
    border: @border;
    margin: 30px auto;
    padding: 30px;
    width: 800px;
  }

  .sys-border {
    padding-left: 10px !important;
    border: 1px solid #f1556c;
  }
}
</style>