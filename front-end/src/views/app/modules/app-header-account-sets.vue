<template>
	<DropdownCustom v-if="currentAccountSets" class="app-header-message-vue" placement="bottom-end" className="app-account-sets-dropdown" :toggleIcon="false" ref="messageDropdown">
		<div class="app-header-icon-item">
			{{currentAccountSets.companyName}}
		</div>
		<div slot="content">
			<div class="h-panel">
				<div class="common-list-container">
					<div @click="changeAccountSets(as)" class="common-list-item" :class="{current:as.id == currentAccountSets.id}" v-for="as of myAccountSets" :key="as.id">
						{{as.companyName}}
					</div>
				</div>
			</div>
		</div>
	</DropdownCustom>
</template>
<script>
	import {mapState} from 'vuex';

	export default {
		name: 'AppHeaderAccountSets',
		data() {
			return {
				messageList: []
			};
		},
		methods: {
			changeAccountSets(as) {
				if (as.id != this.currentAccountSets.id) {
					this.$refs.messageDropdown.hide();
					this.$Loading("正在切换，请稍后...");
					this.$api.common.changeAccountSets(as.id).then(() => {
						this.$Message('切换成功！');
						window.location.replace("/")
					});
				}
			}
		},
		computed: {
			...mapState(['currentAccountSets', 'myAccountSets'])
		}
	};
</script>
<style lang='less'>
	.app-header-message-vue {
		float: left;
		margin-right: 15px;

		.h-dropdowncustom-show {
			height: @layout-header-height;

			.app-header-icon-item {
				margin-right: 0;
			}

			&.h-pop-trigger {
				background: @hover-background-color;
			}
		}
	}

	.app-account-sets-dropdown-dropdown-container {
		width: 300px;
		min-height: 300px;

		.common-list-container {
			.common-list-item {
				cursor: pointer;
				padding: 10px;

				&:hover {
					background: @hover-background-color;
				}

				&.current {
					background: @primary-color;
					color: @white-color;
				}
			}
		}
	}
</style>