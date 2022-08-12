<style lang='less'>
.security-setting-vue {

}
</style>
<template>
  <div class="security-setting-vue">
    <div class="subframe-title">微信绑定</div>
    <div class="common-list-container">
      <div class="common-list-item">
        <div class="common-list-meta">
          <p class="font-bold"><i class="icon-head"></i> 绑定微信账号，可以验证身份，使用更加安全！</p>
          <p>当前状态：已绑定</p>
        </div>
        <div class="common-list-action"></div>
      </div>
      <div class="common-list-item">
        <div class="common-list-meta">
          <img src="/images/avatar.png">
        </div>
        <div class="common-list-action" align="center"><Button color="primary">修改绑定</Button></div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "BindingWebchat",
  data() {
    return {

    };
  },
  mounted() {
    this.init();
  },
  methods: {
    init() {

    }
  },
  computed: {

  }
};
</script>
