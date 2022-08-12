<template>
	<div id="app">
		<Layout class="app-frame" :siderCollapsed="sliderCollapsed" :siderFixed="layoutConfig.siderFixed">
			<Sider :theme="layoutConfig.siderTheme">
				<appMenu :theme="layoutConfig.siderTheme"></appMenu>
			</Sider>
			<Layout :headerFixed="layoutConfig.headerFixed">
				<HHeader theme="white">
					<appHead @openSetting="openSetting=true" :layoutConfig="layoutConfig"></appHead>
				</HHeader>
				<SysTabs v-if="layoutConfig.showSystab" homePage="Home"></SysTabs>
				<Content>
					<div class="app-frame-content ">
						<router-view v-if="isRouterAlive"></router-view>
					</div>
					<HFooter>
						<appFooter></appFooter>
					</HFooter>
				</Content>
			</Layout>
		</Layout>
	</div>
</template>
<script>

	import appHead from './app/app-header';
	import appMenu from './app/app-menu';
	import appFooter from './app/app-footer';
	import {mapState} from 'vuex';
	import SysTabs from './app/sys-tabs/sys-tabs';

	export default {
		name: "FXY",
		provide() {
			return {
				reload: this.reload
			}
		},
		data() {
			return {
				openSetting: false,
				isRouterAlive: true,
				layoutConfig: {
					siderTheme: 'dark',
					showSystab: false,
					headerFixed: true,
					siderFixed: true
				}
			};
		},
		methods: {
			updateLayoutConfig({key, value}) {
				this.layoutConfig[key] = value;
			},
			reload() {
				this.isRouterAlive = false;
				this.$nextTick(() => {
					this.isRouterAlive = true;
				});
			}
		},
		computed: {
			...mapState(['sliderCollapsed'])
		},
		components: {
			appHead,
			appMenu,
			appFooter,
			SysTabs
		}
	};
</script>
