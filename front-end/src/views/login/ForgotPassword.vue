<template>
	<div class="login-frame">
		<div class="login-name login-input">
			<input type="text" name="mobile" v-model="form.mobile" autocomplete="off"/>
			<span class="placeholder" :class="{fixed: form.mobile !== '' && form.mobile != null}">输入手机号，快速找回密码</span>
		</div>
		<div class="login-password login-input">
			<div class="h-input-group">
				<input v-model="form.code" type="text" placeholder="验证码" maxlength="4"/>
				<SmsVerificationCode :mobile="form.mobile"/>
			</div>
		</div>
		<div class="login-name login-input">
			<input type="password" v-model="form.newPassword" autocomplete="off"/>
			<span class="placeholder" :class="{fixed: form.newPassword !== '' && form.newPassword != null}">新密码</span>
		</div>
		<div class="login-name login-input">
			<input type="password" v-model="form.repeatPassword" autocomplete="off"/>
			<span class="placeholder" :class="{fixed: form.repeatPassword !== '' && form.repeatPassword != null}">确认密码</span>
		</div>
		<div class="buttonDiv">
			<Button :loading="loading" block color="primary" size="l" @click="regSubmit">修改密码</Button>
		</div>
		<div class="margin" style="margin-bottom: 0 !important;">
			<span class="text-hover" @click="$emit('input','LoginForm')">返回登录</span>
		</div>
	</div>
</template>
<script>
	import SmsVerificationCode from "../../components/SmsVerificationCode"

	export default {
		name: 'ForgotPassword',
		components: {SmsVerificationCode},
		data() {
			return {
				form: {
					mobile: "",
					code: "",
					newPassword: "",
					repeatPassword: "",
				},
				loading: false
			};
		},
		computed: {
			isValid() {
				return Object.keys(this.form).every(key => !!this.form[key]) && this.form.newPassword === this.form.repeatPassword;
			}
		},
		methods: {
			regSubmit() {
				if (this.isValid) {
					this.loading = true;
					this.$api.common.resetPassword(this.form).then(() => {
						this.$Message("密码重置成功！");
						this.$emit('input', 'LoginForm');
					}).finally(() => {
						this.loading = false;
					});
				}
			}
		}
	}
</script>