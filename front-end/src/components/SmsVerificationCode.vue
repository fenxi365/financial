<template>
	<Button color="primary" @click="sendSms" :disabled="disabled" :loading="loading">{{text}}</Button>
</template>

<script>
	const mobileReg = /^1(3|4|5|6|7|8|9)\d{9}$/;

	export default {
		name: "SmsVerificationCode",
		props: {
			mobile: String,
			api: {
				type: String,
				default: 'sendMsg'
			}
		},
		data() {
			return {
				text: "发送验证码",
				hasBeenSent: false,
				loading: false,
				count: 59
			}
		},
		computed: {
			disabled() {
				return this.hasBeenSent || !mobileReg.test(this.mobile);
			}
		},
		methods: {
			sendSms() {
				if (mobileReg.test(this.mobile)) {
					this.text = "正在发送...";
					this.loading = true;
					this.$api.common[this.api](this.mobile).then(() => {
						this.loading = false;
						this.hasBeenSent = true;
						this.countdown();
						this.$emit("success");
					}).catch(() => {
						this.loading = false;
						this.text = "发送验证码";
					});
				}
			},
			countdown() {
				this.timer = setTimeout(() => {
					this.count--;
					this.text = "重新发送 (" + this.count + ")";
					if (this.count == 0) {
						this.text = "重新发送";
						this.hasBeenSent = false;
						this.count = 59;
						clearTimeout(this.timer);
					} else {
						this.countdown();
					}
				}, 1000);
			}
		}
	}
</script>

<style scoped>

</style>