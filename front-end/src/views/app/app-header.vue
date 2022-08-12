<template>
  <div class="app-header">
    <div style="width:50px;float:left;" v-if="currentAccountSets">
      <Button :icon="sliderCollapsed ? 'icon-align-right':'icon-align-left'" size="l" noBorder class="font20"
              @click="sliderCollapsed=!sliderCollapsed"></Button>
    </div>
    <div class="float-right app-header-info" v-if="currentAccountSets">
      <div class="app-header-icon-item">
        当前账套：{{ currentAccountSets.companyName }}
      </div>
      <div class="app-header-icon-item" @click="init">
        核算组织：
        <TreePicker :option="orgOption" @change="orgChange" style="display: inline-block;min-width: 150px"
                    ref="orgTreePicker" v-model="currentOrgId"></TreePicker>
      </div>
      <div class="app-header-icon-item">
        {{ accountDate }}
      </div>
      <DropdownMenu className="app-header-dropdown" trigger="click" offset="0 5" :width="150" placement="bottom-end"
                    :datas="infoMenu" @onclick="trigger">
        <Avatar :src="avatarUrl" :width="30"><span>{{ User.realName }}</span></Avatar>
      </DropdownMenu>
    </div>
  </div>
</template>
<script>
import {mapState} from 'vuex';
import moment from 'moment';
import appHeaderMessage from './modules/app-header-message';
import AppHeaderAccountSets from "./modules/app-header-account-sets";

export default {
  components: {
    AppHeaderAccountSets,
    appHeaderMessage
  },
  data() {
    return {
      searchText: '',
      orgOption: {
        keyName: 'id',
        parentName: 'parentId',
        titleName: 'title',
        dataMode: 'list',
        datas: []
      },
      currentOrgId: null,
      infoMenu: [
        {key: 'change', title: '切换账套', icon: 'h-icon-setting'},
        {key: 'info', title: '个人信息', icon: 'h-icon-user'},
        {key: 'logout', title: '退出登录', icon: 'h-icon-outbox'}
      ]
    };
  },
  computed: {
    ...mapState(['User', 'currentAccountSets', 'orgDatas', 'currentOrg']),
    sliderCollapsed: {
      get() {
        return this.$store.state.sliderCollapsed;
      },
      set(value) {
        this.$store.commit('updateSliderCollapse', value);
      }
    },
    accountDate() {
      return this.currentOrg ? moment(this.currentOrg.currentAccountDate).format("YYYY年第MM期") : null;
    },
    avatarUrl() {
      return this.User.avatarUrl || '/images/yun.png'
    }
  },
  mounted() {
    this.init();
    // this.loadOrg();
    const resizeEvent = window.addEventListener('resize', () => {
      if (this.sliderCollapsed && window.innerWidth > 900) {
        this.sliderCollapsed = false;
      } else if (!this.sliderCollapsed && window.innerWidth < 900) {
        this.sliderCollapsed = true;
      }
      if (!this.currentAccountSets) {
        this.sliderCollapsed = true;
      }
    });
    this.$once('hook:beforeDestroy', () => {
      window.removeEventListener('resize', resizeEvent);
    });
    window.dispatchEvent(new Event('resize'));
  },
  methods: {
    init() {
      this.currentOrgId = this.$store.state.currentOrgId;
      this.orgOption.datas = this.orgDatas.map(val => {
        return {id: val.id, name:val.name, type: val.type, title: `[${val.code}]${val.name}`, parentId: val.parentId,currentAccountDate:val.currentAccountDate,enableDate:val.enableDate}
      });
      this.$nextTick(() => {
        this.$refs.orgTreePicker && this.$refs.orgTreePicker.expandAll();
      });
    },
    orgChange(item) {
      if (this.$store.state.currentOrgId != item.id) {
        this.$Confirm(`确认切换到${item.title}视角？`, '系统提示').then(() => {
          this.$api.common.selectOrg(item).then(() => {
            this.$Message.success('切换成功')
            window.location.replace("/");
          });
          this.$store.commit('updateCurrentOrgId', item.id);
        }).catch(() => {
          this.currentOrgId = this.$store.state.currentOrgId;
          this.$nextTick(() => {
            this.$refs.orgTreePicker && this.$refs.orgTreePicker.expandAll();
          });
        });
      }
    },
    trigger(data) {
      if (data === 'logout') {
        this.$api.common.logout().then(() => {
          localStorage.removeItem("currentOrgId");
          window.location.replace("/");
        });
      } else if (data === 'change') {
        this.$Modal({
          title: '请选择切换账套',
          closeOnMask: false,
          hasCloseIcon: true,
          hasDivider: true,
          width: 400,
          component: {
            vue: (resolve) => {
              require(['./SelectAccountSet'], resolve);
            },
            datas: {}
          },
          events: {
            success: () => {
            }
          }
        });
      } else if (data === 'info') {
        this.$router.push({name: 'PersonalSetting'});
      }
    },
    // loadOrg() {
    //   this.currentAccountSets && this.$api.setting.organization.list({accountSetsId: this.currentAccountSets.id}).then(({data}) => {
    //     this.orgOption.datas = data.map(val => {
    //       return {id: val.id, name: `[${val.code}]${val.name}`, type: val.type, title: val.name, parentId: val.parentId}
    //     });
    //     if (!localStorage.getItem("currentOrgId")) {
    //       localStorage.setItem("currentOrgId", data[0].id);
    //       this.$store.commit('updateCurrentOrgId', data[0].id);
    //     }
    //     this.$nextTick(() => {
    //       this.currentOrgId = localStorage.getItem("currentOrgId");
    //       this.$refs.orgTreePicker.expandAll();
    //     });
    //     this.$store.commit('updateOrgDatas', this.orgDatas);
    //   });
    // },
  },
  // watch: {
  //   currentAccountSets() {
  //     this.loadOrg();
  //   }
  // },
};
</script>
<style lang="less">
.app-header {
  color: rgba(49, 58, 70, 0.8);

  .h-autocomplete {
    line-height: 1.5;
    float: left;
    margin-top: 15px;
    margin-right: 20px;
    width: 120px;

    &-show, &-show:hover, &-show.focusing {
      outline: none;
      box-shadow: none;
      border-color: transparent;
      border-radius: 0;
    }

    &-show.focusing {
      border-bottom: 1px solid #eee;
    }
  }

  &-info &-icon-item {
    cursor: pointer;
    display: inline-block;
    float: left;
    padding: 0 15px;
    height: @layout-header-height;
    line-height: @layout-header-height;
    margin-right: 10px;

    &:hover {
      background: @hover-background-color;
    }

    i {
      font-size: 18px;
    }

    a {
      color: inherit;
    }

    .h-badge {
      margin: 20px 0;
      display: block;
    }
  }

  .h-dropdownmenu {
    float: left;
  }

  &-dropdown {
    float: right;
    margin-left: 10px;
    padding: 0 20px 0 15px;

    .h-icon-down {
      right: 20px;
    }

    cursor: pointer;

    &:hover, &.h-pop-trigger {
      background: @hover-background-color;
    }

    &-dropdown {
      padding: 5px 0;

      .h-dropdownmenu-item {
        padding: 8px 20px;
      }
    }
  }

  &-menus {
    display: inline-block;
    vertical-align: top;

    > div {
      display: inline-block;
      font-size: 15px;
      padding: 0 25px;
      color: @dark-color;

      &:hover {
        color: @primary-color;
      }

      + div {
        margin-left: 5px;
      }

      &.h-tab-selected {
        color: @white-color;
        background-color: @primary-color;
      }
    }
  }
}
</style>
