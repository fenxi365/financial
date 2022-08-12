<template>
	<div class="notice-setting-vue">
		<div class="subframe-title">密码修改</div>
		<Form v-width="300" mode="block" :model="model" :rules="validationRules" ref="form">
			<FormItem label="原密码" prop="original">
				<input type="password" v-model="model.original"/>
			</FormItem>
			<FormItem label="新密码" prop="newPassword">
				<input type="password" v-model="model.newPassword"/>
			</FormItem>
			<FormItem label="重复密码" prop="repeatPassword">
				<input type="password" v-model="model.repeatPassword"/>
			</FormItem>
			<FormItem>
				<Button @click="save" color="primary" :loading="isLoading">保存</Button>
			</FormItem>
		</Form>
	</div>
</template>
<script>
	export default {
		name: "ChangePassword",
		data() {
			return {
				isLoading: false,
				model: {
					original: "",
					newPassword: "",
					repeatPassword: "",
				},
				validationRules: {
					required: ["original", "newPassword", "repeatPassword"],
					combineRules: [{
						refs: ['newPassword', 'repeatPassword'],
						valid: {
							valid: 'equal',
							message: '两次输入的密码不一致'
						}
					}]
				}
			};
		},
		methods: {
			save() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.isLoading = true;
					this.$api.common.updatePwd(this.model).then(() => {
						this.$Message('更新密码成功');
						this.isLoading = false;
					}).catch(()=>{
						this.isLoading = false;
					});
				}
			}
		},
		computed: {}
	};
</script>
