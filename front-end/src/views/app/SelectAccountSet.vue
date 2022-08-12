<template>
  <div class="select-account-set-vue">
    <div class="select-account-set-container">
      <div class="select-account-set-content">
        <div class="select-common-list-container" v-for="as in datas">
          <div @click="changeAccountSets(as)" class="common-list-item" :class="as.id ===currentAccountSets.id?'current' :''">
            <div>{{ as.companyName }}</div>
            <span class="h-icon-right"></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from "vuex";

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2020 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : financial</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2022/6/6 10:39</li>
 * <li>@author     : ____′↘TangSheng</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
export default {
  name: "SelectAccountSet",
  computed: {
    ...mapState(['User', 'currentAccountSets']),
  },
  data() {
    return {
      datas: [],
    }
  },
  methods: {
    changeAccountSets(as) {
      this.$Loading("正在选择，请稍后...");
      this.$api.common.selectAccountSets(as.id, this.User).then(({data}) => {
        this.$Message('选择成功！');
        localStorage.removeItem("user");
        window.location.replace("/")
      });
    },
    loadAccountSets(){
      this.$api.setting.accountSets.list().then(({data}) => {
        this.datas = data || [];
      })
    }
  },
  created() {
    this.loadAccountSets();
  }
}
</script>


<style scoped lang="less">

.select-account-set-vue {

  .select-account-set-content {
    background: #FFF;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 1px 1px 0 #eee;

    .select-account-set-title {
      font-size: 18px;
      color: #3a3a3a;
      line-height: 1;
      font-weight: bold;
      padding-bottom: 15px;
    }

    .select-account-set-back {
      padding-bottom: 20px;
      display: flex;
      color: #999999;
      line-height: 1;
      cursor: pointer;
      justify-content: flex-end;
    }
    .select-common-list-container {
      margin: 20px;
      .common-list-item {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        cursor: pointer;
        border-radius: 5px;
        background: @hover-background-color;

        &.current {
          background: @primary-color;
          color: @white-color;
        }
      }
    }
  }
}

</style>