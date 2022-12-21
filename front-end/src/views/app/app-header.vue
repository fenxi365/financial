<template>
	<div class="app-header">
		<div style="width:50px;float:left;" v-if="currentAccountSets">
			<Button :icon="sliderCollapsed ? 'icon-align-right':'icon-align-left'" size="l" noBorder class="font20" @click="sliderCollapsed=!sliderCollapsed"></Button>
		</div>
		<div class="float-right app-header-info">
			<app-header-account-sets/>
			<div class="app-header-icon-item">
				{{accountDate}}
			</div>
			<DropdownMenu className="app-header-dropdown" trigger="click" offset="0 5" :width="150" placement="bottom-end" :datas="infoMenu" @onclick="trigger">
				<Avatar :src="avatarUrl" :width="30"><span>{{User.realName}}</span></Avatar>
			</DropdownMenu>
		</div>
	</div>
</template>
<script>
	import {mapState} from 'vuex';
	import moment from 'moment';
	import appHeaderMessage from './modules/app-header-message';
	import AppHeaderAccountSets from "./modules/app-header-account-sets";

	export default {
		components: {
			AppHeaderAccountSets,
			appHeaderMessage
		},
		data() {
			return {
				searchText: '',
				infoMenu: [
					{key: 'info', title: '个人信息', icon: 'h-icon-user'},
					{key: 'logout', title: '退出登录', icon: 'h-icon-outbox'}
				]
			};
		},
		computed: {
			...mapState(['User', 'currentAccountSets']),
			sliderCollapsed: {
				get() {
					return this.$store.state.sliderCollapsed;
				},
				set(value) {
					this.$store.commit('updateSliderCollapse', value);
				}
			},
			accountDate() {
				return this.currentAccountSets ? moment(this.currentAccountSets.currentAccountDate).format("YYYY年第MM期") : null;
			},
			avatarUrl() {
				return this.User.avatarUrl || '/images/yun.png'
			}
		},
		mounted() {
			const resizeEvent = window.addEventListener('resize', () => {
				if (this.sliderCollapsed && window.innerWidth > 900) {
					this.sliderCollapsed = false;
				} else if (!this.sliderCollapsed && window.innerWidth < 900) {
					this.sliderCollapsed = true;
				}
				if (!this.currentAccountSets) {
					this.sliderCollapsed = true;
				}
			});
			this.$once('hook:beforeDestroy', () => {
				window.removeEventListener('resize', resizeEvent);
			});
			window.dispatchEvent(new Event('resize'));
		},
		methods: {
			trigger(data) {
				if (data == 'logout') {
					this.$api.common.logout().then(() => {
						window.location.replace("/");
					});
				} else {
					this.$router.push({name: 'PersonalSetting'});
				}
			}
		}
	};
</script>
<style lang="less">
	.app-header {
		color: rgba(49, 58, 70, 0.8);

		.h-autocomplete {
			line-height: 1.5;
			float: left;
			margin-top: 15px;
			margin-right: 20px;
			width: 120px;

			&-show, &-show:hover, &-show.focusing {
				outline: none;
				box-shadow: none;
				border-color: transparent;
				border-radius: 0;
			}

			&-show.focusing {
				border-bottom: 1px solid #eee;
			}
		}

		&-info &-icon-item {
			cursor: pointer;
			display: inline-block;
			float: left;
			padding: 0 15px;
			height: @layout-header-height;
			line-height: @layout-header-height;
			margin-right: 10px;

			&:hover {
				background: @hover-background-color;
			}

			i {
				font-size: 18px;
			}

			a {
				color: inherit;
			}

			.h-badge {
				margin: 20px 0;
				display: block;
			}
		}

		.h-dropdownmenu {
			float: left;
		}

		&-dropdown {
			float: right;
			margin-left: 10px;
			padding: 0 20px 0 15px;

			.h-icon-down {
				right: 20px;
			}

			cursor: pointer;

			&:hover, &.h-pop-trigger {
				background: @hover-background-color;
			}

			&-dropdown {
				padding: 5px 0;

				.h-dropdownmenu-item {
					padding: 8px 20px;
				}
			}
		}

		&-menus {
			display: inline-block;
			vertical-align: top;

			> div {
				display: inline-block;
				font-size: 15px;
				padding: 0 25px;
				color: @dark-color;

				&:hover {
					color: @primary-color;
				}

				+ div {
					margin-left: 5px;
				}

				&.h-tab-selected {
					color: @white-color;
					background-color: @primary-color;
				}
			}
		}
	}
</style>
