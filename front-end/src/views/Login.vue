<template>
	<div class="login-vue">
		<div class="login-container">
			<div class="login-content">
        <div class="app-logo">
          <span class="app-logo-icon"></span><span class="app-logo-text" style="color: #929292 ">纷析云财务软件</span>
        </div>
<!--				<div class="login-title">纷析云 - 财务</div>-->
				<component v-model="currentComponent" :is="currentComponent"></component>
			</div>
			<p class="copyright"> Copyright © 2019 纷析云</p>
      <p class="copyright">技术支持：13456781004(微信)</p>
		</div>
	</div>
</template>
<script>
	import ForgotPassword from "./login/ForgotPassword";
	import Registered from "./login/Registered";
	import LoginForm from "./login/LoginForm";

	export default {
		name: 'Login',
		components: {LoginForm, Registered, ForgotPassword},
		data() {
			return {
				currentComponent: 'LoginForm'
			};
		}
	};
</script>
<style lang="less">
	@gradient-color: #3788ee;
	@bg-color: #f7f8fa;
	@title-color: #3a3a3a;
	@text-color: #7e7e7e;
	@placeholder-color: #7e7e7e;
	.login-vue {
		text-align: center;
		position: absolute;
		top: 0;
		bottom: 0;
		right: 0;
		left: 0;
		background: @bg-color;

		.login-container {
			width: 360px;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);

			.login-content {
				letter-spacing: 2px;
				background: #FFF;
				padding: 70px 30px 20px;
				box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.06);
				border-radius: 3px;
				box-sizing: border-box;

				.login-title {
					font-size: 30px;
					color: @title-color;
					line-height: 1;
					margin: -16px 0px 40px;
					font-weight: 200;
				}

				> div > div {
					margin: 30px 0;

					&.login-input {
						position: relative;

						.placeholder {
							position: absolute;
							color: @placeholder-color;
							top: 6px;
							font-size: 16px;
							transition: all .2s;
							left: 0;
							pointer-events: none;

							&.forgot-password {
								left: auto;
								right: 0;
								z-index: 3;
								cursor: pointer;
								pointer-events: auto;

								&:hover {
									color: @primary-color;
								}
							}
						}

						input {
							font-size: 16px;
							padding: 8px 0;
							height: 40px;
							width: 100%;
							border: none;
							border-radius: 0;
							border-bottom: 1px solid #d3d3d3;
							box-shadow: inset 0 0 0 1000px #fff;
							outline: none;
							box-sizing: border-box;
							transition: .3s;
							font-weight: 200;

							&:focus {
								border-bottom-color: @gradient-color;
								box-shadow: inset 0 0 0 1000px #fff;
							}
						}

						input:focus + .placeholder, .placeholder.fixed {
							font-size: 13px;
							top: -16px;
						}

						input:-webkit-autofill + .placeholder {
							font-size: 13px;
							top: -16px;
						}
					}
				}

				> div .buttonDiv {
					margin-top: 45px;

					.h-btn {
						padding: 12px 0;
						font-size: 18px;
						opacity: .8;
						border-radius: 3px;
						background: @gradient-color;
						border-color: @gradient-color;

						&:hover {
							opacity: 1;
							background: @gradient-color;
							border-color: @gradient-color;
						}
					}
				}
			}

			.copyright {
				letter-spacing: 1px;
				margin-top: 30px;
				color: @text-color;

				a {
					color: @text-color;
				}
			}
		}
	}
</style>
