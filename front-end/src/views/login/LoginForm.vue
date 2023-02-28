<template>
  <div class="login-frame">
    <div>
      <DropdownCustom placement="top" trigger="hover" :toggleIcon="false">
        <Button size="xs" icon="fa fa-wechat" style="margin-right: 16px">源码咨询</Button>
        <div slot="content">
          <img width="200" src="../../assets/code.jpeg" alt="">
        </div>
      </DropdownCustom>
      <a class="h-btn h-btn-xs" href="https://gitee.com/flyemu/public-financial" target="_blank"> <i class="fa fa-github"></i> gitee</a>
    </div>
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
      },
      loading: false
    }
  },
  methods: {
    submit() {
      if (this.login.mobile && this.login.password) {
        this.loading = true
        this.$api.common.login(this.login).then(() => {
          window.location.replace('/');
        }).catch(() => {
          this.loading = false
        });
      }
    }
  }
}
</script>
