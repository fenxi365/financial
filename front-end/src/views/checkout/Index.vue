<template>
	<app-content class="h-panel">
		<Tabs :datas="datas" v-model="selected" @change="change"></Tabs>
		<router-view/>
	</app-content>
</template>

<script>
	export default {
		name: "check-out",
		data() {
			return {
				datas: [{
					title: '期末结转',
					key: 'CheckList'
				}, {
					title: '反结账',
					key: 'UnCheckOut'
				}],
				selected: 'CheckList'
			}
		},
		methods: {
			change(data) {
				this.$router.push({name: data.key})
			}
		}
	}
</script>