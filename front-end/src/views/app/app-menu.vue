<template>
	<div class="app-menu">
		<appLogo></appLogo>
		<Menu accordion v-if="currentAccountSets" :datas="menus" :inlineCollapsed="sliderCollapsed" @select="trigger" ref='menu' :className="`h-menu-${theme}`"></Menu>
		<div class="app-menu-mask" @click="hideMenu"></div>
	</div>
</template>
<script>

	import menuConfig from '../../js/config/menu-config';
	import {mapState} from 'vuex';
	import appLogo from './app-logo';

	export default {
		name: "AppMenu",
		props: {
			theme: String
		},
		data() {
			return {
				menus: []
			};
		},
		watch: {
			$route() {
				this.menuSelect();
			}
		},
		mounted() {
			this.menus = menuConfig[this.User.role];
			this.menuSelect();
		},
		computed: {
			...mapState(['User', 'sliderCollapsed', 'currentAccountSets'])
		},
		methods: {
			menuSelect() {
				if (this.$route.name && this.currentAccountSets) {
					this.$refs.menu.select(this.$route.name);
				}
			},
			trigger(data) {
				if (data.reportId) {
					this.$router.push({name: 'ReportView', params: {reportId: data.reportId}});
				} else {
					this.$router.push({name: data.key});
				}
			},
			hideMenu() {
				this.$store.commit('updateSliderCollapse', true);
			}
		},
		components: {
			appLogo
		}
	};
</script>
<style lang="less">

	.app-menu {
		.h-menu {
			font-size: 14px;

			.h-menu-li-selected {
				.h-menu-show:after {
					width: 4px;
				}
			}

			> li > .h-menu-show {
				font-size: 15px;

				.h-menu-show-icon {
					font-size: 20px;
				}

				.h-menu-show-desc {
					transition: opacity 0.1s cubic-bezier(0.645, 0.045, 0.355, 1), width 0.1s cubic-bezier(0.645, 0.045, 0.355, 1);
				}
			}
		}

		.h-menu.h-menu-size-collapse > .h-menu-li > .h-menu-show {
			padding-left: 24px;

			.h-menu-show-icon {
				font-size: 20px;
			}
		}

		.h-menu.h-menu-white {
			color: rgb(49, 58, 70);
		}

	}

</style>
