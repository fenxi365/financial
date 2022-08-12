<template>
  <div class="login-frame">
    <div class="login-name login-input">
      <input type="text" name="mobile" v-model="login.mobile" autocomplete="off"/>
      <span class="placeholder" :class="{fixed: login.mobile !== '' && login.mobile != null}">手机号</span>
    </div>
    <div class="login-password login-input">
      <input type="password" name="password" v-model="login.password" @keyup.enter="submit" autocomplete="off"/>
      <span class="placeholder" :class="{fixed: login.password !== '' && login.password != null}">密码</span>
      <span @click="$emit('input','ForgotPassword')" class="placeholder forgot-password text-hover" :class="{fixed: login.password !== '' && login.password != null}">忘记密码</span>
    </div>
    <div class="buttonDiv">
      <Button :loading="loading" block color="primary" size="l" @click="submit">登录</Button>
    </div>
    <div class="margin" style="margin-bottom: 0 !important;">
      <span class="text-hover" @click="$emit('input','Registered')">立即注册</span>
    </div>
  </div>
</template>
<script>
export default {
  name: 'LoginForm',
  data() {
    return {
      login: {
        mobile: "",
        password: "",
        forever: true,
      },
      loading: false
    }
  },
  methods: {
    submit() {
      if (this.login.mobile && this.login.password) {
        this.loading = true
        this.$api.common.login(this.login).then(({data}) => {
          if (data.accountSetsList.length === 0 || data.accountSetsList.length === 1) {
            window.location.replace("/")
          } else {
            localStorage.setItem("user", JSON.stringify(data));
            window.location.replace("/select-account-set");
            this.loading = false
          }
        }).catch(() => {
          this.loading = false
        });
      }
    }
  }
}
</script>
