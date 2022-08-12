<template>
	<div class="frame-page">
		<slot/>
	</div>
</template>

<script>
	export default {
		name: "AppContent",
		props: {
			title: String
		},
		data() {
			return {
				minHeight: (window.innerHeight - 102) + 'px'
			}
		},
		mounted() {
			window.document.title = '纷析云 - ' + (this.title || this.$route.meta.title);
		}
	}
</script>

<style scoped>

</style>
