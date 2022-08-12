<template>
	<app-content class="account-setting-vue frame-flex-page h-panel">
		<div class="frame-left">
			<sub-menu :datas="menus"></sub-menu>
		</div>
		<div class="frame-main">
			<router-view></router-view>
		</div>
	</app-content>
</template>
<script>
	export default {
		data() {
			return {
				menus: [{
					title: '个人设置',
					key: 'PersonalSetting'
				}, {
					title: '修改密码',
					key: 'ChangePassword'
				}, {
					title: '修改手机',
					key: 'ChangePhoneNumber'
				}/*, {
					title: '微信绑定',
					key: 'BindingWebchat'
				}*/]
			};
		},
		mounted() {
			this.init();
		},
		methods: {
			init() {

			}
		},
		computed: {}
	};
</script>
<style lang='less'>
	.account-setting-vue {

	}
</style>


