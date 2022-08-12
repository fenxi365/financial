<template>
	<app-content class="h-panel">
		<div class="h-panel-body padding">
      <div>
			立即授权
      </div>
		</div>
	</app-content>
</template>

<script>
	import {mapState} from 'vuex';
	import jQuery from 'jquery';

	const emptyForm = {
		"id": "0",
		"code": "",
		"name": "",
		"mnemonicCode": "",
		"balanceDirection": "",
		"status": "0",
		"parentId": "0"
	};

	export default {
		name: "BossApp",
		data() {
			return {

			};
		},
		computed: {
			...mapState(['currentAccountSets']),
		},
		watch: {

		},
		methods: {}




	};
</script>
<style lang="less" scoped>
	.result {
		width: 500px;
		height: 250px;

		.pic {
			width: 238px;
			height: 120px;
			background-image: url("../../assets/settings.png");
			background-repeat: no-repeat;
			margin: 20px auto;
		}


		.pic-body {
			margin-top: 50px;
			position: relative;

			&.beginningBalance {
				.pic {
					background-position: -160px 0px;
				}

				span {
					position: absolute;
				}

				.span1 {
					top: 0;
					left: 22px;
				}

				.span2 {
					top: 50px;
					left: 0;
					width: 100%;
				}

				.span3 {
					top: 0;
					right: 10px;
				}

				&.right {
					.pic {
						height: 130px;
						background-position: -160px -132px;
					}

					.span1 {
						top: 25px;
					}

					.span3 {
						top: -25px;
					}
				}

				&.left {
					.pic {
						height: 130px;
						background-position: -160px -272px;
					}

					.span1 {
						top: -25px;
					}

					.span3 {
						top: 25px;
					}
				}
			}

			&.liabilities {
				.pic {
					background-position: -420px 5px;
				}

				span {
					position: absolute;
				}

				.span1 {
					top: 0;
					left: 22px;
				}

				.span2 {
					top: 50px;
					left: 0;
					width: 100%;
				}

				.span3 {
					top: 0;
					right: 10px;
				}

				&.right {
					.pic {
						height: 130px;
						background-position: -420px -132px;
					}

					.span1 {
						top: 25px;
					}

					.span3 {
						top: -25px;
					}
				}

				&.left {
					.pic {
						height: 130px;
						background-position: -420px -272px;
					}

					.span1 {
						top: -25px;
					}

					.span3 {
						top: 25px;
					}
				}
			}
		}
	}

	.editblock {
		width: 100%;
		height: 100%;
		line-height: 33px;
	}

	.edit-hover:hover {
		cursor: pointer;
		background-color: @gray2-color;
	}
</style>
