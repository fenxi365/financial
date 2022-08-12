<template>
	<div class="login-frame">
		<div class="login-name login-input">
			<input type="text" name="mobile" v-model="reg.mobile" autocomplete="off"/>
			<span class="placeholder" :class="{fixed: reg.mobile !== '' && reg.mobile != null}">输入手机号，快速注册</span>
		</div>
		<div class="login-password login-input">
			<div class="h-input-group">
				<input v-model="reg.code" type="text" placeholder="验证码" maxlength="4"/>
				<SmsVerificationCode api="regMsg" :mobile="reg.mobile"/>
			</div>
		</div>
		<div class="buttonDiv">
			<Button :loading="loading" block color="primary" size="l" @click="regSubmit">注册</Button>
		</div>
		<div class="margin" style="margin-bottom: 0 !important;">
			<span class="text-hover" @click="$emit('input','LoginForm')">返回登录</span>
		</div>
	</div>
</template>
<script>
	import SmsVerificationCode from "../../components/SmsVerificationCode"

	export default {
		name: 'Registered',
		components: {SmsVerificationCode},
		data() {
			return {
				reg: {
					mobile: "",
					code: "",
				},
				loading: false
			};
		},
		methods: {
			regSubmit() {
				if (this.reg.mobile && this.reg.code) {
					this.loading = true;
					this.$api.common.register(this.reg).then(() => {
						window.location.replace('/');
					}).finally(() => {
						this.loading = false
					});
				}
			}
		}
	}
</script>