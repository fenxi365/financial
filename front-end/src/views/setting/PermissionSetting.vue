<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">权限设置</span></div>
		<div class="margin-top margin-left">
			<Button color="primary" @click="showForm=true">新增</Button>
		</div>
		<div class="h-panel-body">
			<Table :datas="datas" :border="true">
				<TableItem title="用户" prop="realName"></TableItem>
				<TableItem title="手机号" prop="mobile"></TableItem>
				<TableItem title="权限" prop="role" dict="roles"></TableItem>
				<TableItem>
					<div class="actions" slot-scope="{data}">
						<span @click="showHandOver=true" v-if="currentAccountSets.creatorId == data.id && data.id == User.id">移交</span>
						<template v-else-if="User.id != data.id && currentAccountSets.creatorId != data.id">
							<span @click="edit(data)">编辑</span>
							<span @click="remove(data)">删除</span>
						</template>
					</div>
				</TableItem>
			</Table>
		</div>
		<Modal v-model="showForm" hasCloseIcon type="drawer-right">
			<div slot="header">当前账套：{{currentAccountSets.companyName}}</div>
			<Form ref="form" v-width="580" :labelWidth="80" :model="form" :rules="validationRules">
				<FormItem label="手机用户" prop="mobile">
					<input type="text" v-model="form.mobile" :disabled="form.id">
				</FormItem>
				<Radio class="cus-h-radio" v-model="form.role" :datas="roles">
					<template slot="item" slot-scope="{item}">
						<span>{{item.title}}</span>
						<div class="desc">{{item.desc}}</div>
					</template>
				</Radio>
			</Form>
			<div class="text-center margin-top">
				<Button color="green" @click="addUser" :loading="loading">{{form.id?'更新':'保存'}}</Button>
				<Button @click="showForm=false">取消</Button>
			</div>
		</Modal>
		<Modal v-model="showNewForm" hasCloseIcon>
			<div slot="header">新增权限</div>
			<div v-width="300" class="margin">
				亲，您输入的手机还没有注册，确认需要新增吗？
				为保障您的数据安全，新注册用户需要验证手机。
			</div>
			<Row type="flex" :space="10" class="margin">
				<Cell><input type="text" v-model="form.mobile" disabled></Cell>
				<Cell>
					<SmsVerificationCode :mobile="form.mobile"/>
				</Cell>
			</Row>
			<Row type="flex" :space="10" class="margin">
				<Cell><input v-model="msgCode" type="text" placeholder="请输入验证码"></Cell>
			</Row>
			<div class="text-center">
				<Button color="green" @click="addNewUser" :loading="loading">确定</Button>
				<Button @click="showNewForm=false">取消</Button>
			</div>
		</Modal>
		<Modal v-model="showHandOver" hasCloseIcon>
			<div slot="header">移交账套</div>
			<div v-width="300" class="margin">
				<template v-if="authenticated">
					请验证接收人的手机，他即将接收的账套是：
				</template>
				<template v-else>
					请验证移交人的手机，您即将移交的账套是：
				</template>
				<br>
				{{currentAccountSets.companyName}}
				<p class="red-color">注意：移交账套后，您将不能再查看该账套！</p>
			</div>
			<div v-show="authenticated">
				<div class="margin h-input-group">
					<input type="text" v-model="receiverMobile" placeholder="请输入接收人手机">
					<SmsVerificationCode :mobile="receiverMobile"/>
				</div>
				<div class="margin">
					<input v-model="verificationCode" type="text" placeholder="请输入验证码"/>
				</div>
			</div>
			<div v-show="!authenticated">
				<div class="margin h-input-group">
					<input type="text" v-model="User.mobile" disabled>
					<SmsVerificationCode :mobile="User.mobile"/>
				</div>
				<div class="margin">
					<input v-model="verificationCode" type="text" placeholder="请输入验证码"/>
				</div>
			</div>
			<div class="text-center">
				<Button color="red" @click="handOver" :loading="loading">确定</Button>
				<Button @click="showHandOver=false">取消</Button>
			</div>
		</Modal>
	</app-content>
</template>

<script>

	import {mapState} from 'vuex';
	import SmsVerificationCode from "../../components/SmsVerificationCode";

	const emptyForm = {
		"role": "Manager",
		"mobile": "",
	};

	export default {
		name: 'PermissionSetting',
		components: {SmsVerificationCode},
		data() {
			return {
				datas: [],
				roles: [
					{
						key: 'Manager',
						title: '账套管理员',
						desc: '凭证 | 结账 | 账簿 | 报表 | 新增账套 | 删除账套'
					}/*, {
						key: 'Director',
						title: '主管',
						desc: '凭证 | 出纳 | 发票 | 工资 | 固定资产 | 税务 | 期末结转 | 账簿 | 报表 | 新增账套\n'
					}*/, {
						key: 'Making',
						title: '制单人',
						desc: '凭证 | 结账 | 账簿 | 报表 | 新增账套 '
					}/*, {
						key: 'Cashier',
						title: '出纳',
						desc: '出纳 | 查看凭证、固定资产、账簿和报表 | 新增账套'
					}*/, {
						key: 'View',
						title: '查看',
						desc: '查看凭证、账簿和报表 | 新增账套'
					}],
				form: Object.assign({}, emptyForm),
				showNewForm: false,
				showHandOver: false,
				showForm: false,
				loading: false,
				authenticated: false,
				receiverMobile: '',
				msgSended: false,
				msgTxt: '发送验证码',
				msgCode: '',
				verificationCode: '',
				validationRules: {
					required: ['mobile'],
					mobile: ['mobile']
				}
			};
		},
		computed: {
			...mapState(['currentAccountSets', 'User']),
		},
		watch: {
			showForm(val) {
				if (!val) {
					this.reset();
				}
			}
		},
		methods: {
			loadList() {
				this.$api.setting.user.list().then(({data}) => {
					this.datas = data || [];
				})
			},
			addUser() {
				let validResult = this.$refs.form.valid();
				if (validResult.result) {
					this.loading = true;
					this.$api.setting.accountSets[this.form.id ? 'updateUserRole' : 'addUser'](this.form).then(() => {
						this.loadList();
						this.showForm = false;
						this.loading = false;
					}).catch((rs) => {
						this.loading = false;
						if (rs.code == 501) {
							this.showNewForm = true;
						}
					});
				}
			},
			addNewUser() {
				if (!this.msgCode) {
					this.$Message('请输入验证码！');
					return
				}

				this.loading = true;
				this.$api.setting.accountSets.addNewUser(Object.assign({}, this.form, {code: this.msgCode})).then(() => {
					this.loadList();
					this.showForm = false;
					this.showNewForm = false;
					this.loading = false;
				}).catch((rs) => {
					this.loading = false;
				});
			},
			edit(data) {
				this.form = {
					role: data.role,
					mobile: data.mobile,
					id: data.id
				};
				this.showForm = true;
			},
			remove(data) {
				this.$Confirm("确认删除?").then(() => {
					this.$api.setting.accountSets.removeUser(data.id).then(() => {
						this.loadList();
					})
				})
			},
			reset() {
				this.form = Object.assign({}, emptyForm);
			},
			handOver() {
				if (this.verificationCode) {
					if (!this.authenticated) {
						//移交人身份确认
						this.$api.setting.accountSets.identification({code: this.verificationCode}).then(() => {
							this.verificationCode = "";
							this.authenticated = true;
						});
					} else {
						//移交亲，请再次确定是否移交该账套，移交成功后，接收人登录柠檬云即可查看该账套：浙江欧易新能源有限公司
						this.$api.setting.accountSets.handOver({mobile: this.receiverMobile, code: this.verificationCode}).then(() => {
							window.location.replace("/");
						});
					}
				}
			}
		},
		mounted() {
			this.loadList();
		}
	};
</script>
<style lang="less">
	.cus-h-radio {
		> label {
			display: block;
			height: auto;

			.desc {
				color: @dark4-color;
				padding-left: 20px;
			}
		}
	}
</style>
