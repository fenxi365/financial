<template>
	<div class="app-logo">
		<router-link to="/"><span class="app-logo-icon"></span><span class="app-logo-text">纷析云</span></router-link>
	</div>
</template>
<script>
	export default {
		name: "AppLogo"
	};
</script>
<style lang='less'>
	.app-logo {
		font-family: Futura, Helvetica Neue For Number, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, PingFang SC, Hiragino Sans GB, Microsoft YaHei, Helvetica Neue, Helvetica, Arial, sans-serif;
		padding: 0 24px;
		line-height: @layout-header-height;
		height: @layout-header-height;
		overflow: hidden;
		white-space: nowrap;
		transition: padding .3s;
		text-align: center;

		.app-logo-text {
			font-size: 20px;
			vertical-align: middle;
			color: #FFF;
			font-weight: bold;
		}

		.app-logo-icon {
			background: url(../../assets/logo.png);
			background-size: contain;
			height: 26px;
			width: 26px;
			display: inline-block;
			margin-right: 10px;
			transition: .3s;
			vertical-align: middle;
		}
	}

	.h-layout-sider-collapsed {
		.app-logo-text {
			display: none;
		}

		.app-logo-icon {
			margin-left: 15px;
		}
	}
</style>
