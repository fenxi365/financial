<template>
  <div class="select-account-set-vue">
    <div class="select-account-set-container">
      <div class="select-account-set-content">
        <div class="select-account-set-back" @click="back">
          <span class="h-icon-left"></span> 返回

        </div>
        <div class="select-account-set-title">请选择你的账套</div>
        <div class="select-common-list-container" v-for="as in user.accountSetsList">
          <div @click="changeAccountSets(as)" class="common-list-item">
            <div>{{ as.companyName }}</div>
            <span class="h-icon-right"></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "SelectAccountSet",
  data() {
    return {
      user: {},
    }
  },
  methods: {
    changeAccountSets(as) {
      this.$Loading("正在选择，请稍后...");
      this.$api.common.selectAccountSets(as.id, this.user).then(({data}) => {
        this.$Message('选择成功！');
        localStorage.removeItem("user");
        window.location.replace("/")
      });
    },
    back() {
      localStorage.removeItem("user");
      window.location.replace("/")
    }
  },
  created() {
    let user = localStorage.getItem("user");
    if (user) {
      this.user =JSON.parse(user);
    } else {
      window.location.replace("/")
    }
  }
}
</script>

<style scoped lang="less">

.select-account-set-vue {
  text-align: center;
  position: absolute;
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  background: #f7f8fa;

  .select-account-set-container {
    width: 360px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

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
