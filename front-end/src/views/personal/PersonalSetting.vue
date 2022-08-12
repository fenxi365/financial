<template>
	<div class="notice-setting-vue">
		<div class="subframe-title">个人设置</div>
		<Form v-width="300" mode="block" :model="user" :rules="validationRules" ref="form">
			<FormItem label="邮箱" prop="email">
				<input type="text" v-model="user.email"/>
			</FormItem>
			<FormItem label="姓名" prop="realName">
				<input type="text" v-model="user.realName"/>
			</FormItem>
			<FormItem class="font-bold" style="color: red;font-size: xx-small">
				* 当您录凭证或者审核凭证时，此姓名即为您的制单人姓名、审核人姓名。
			</FormItem>
			<FormItem>
				<Button @click="save" color="primary" :loading="isLoading">保存</Button>
			</FormItem>
		</Form>
	</div>
</template>
<script>
	import {mapGetters} from 'vuex';

	export default {
		name: "PersonalSetting",
		data() {
			return {
				isLoading: false,
				user: {
					email: '',
					realName: ''
				},
				validationRules: {
					required: ['realName', 'email'],
					email: ['email']
				}
			};
		},
		computed: {
			...mapGetters(['account'])
		},
		mounted() {
			this.init();
		},
		methods: {
			init() {
				this.user = {
					email: this.account.email,
					realName: this.account.realName
				}
			},
			save() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.isLoading = true;
					this.$api.common.updateUser(this.user).then(() => {
						this.$Message('更新成功');
						this.isLoading = false;
						this.$store.dispatch("init");
					});
				}
			}
		}
	};
</script>
