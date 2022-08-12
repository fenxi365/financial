<template>
	<app-content class="h-panel">
		<div class="h-panel-bar"><span class="h-panel-title">{{$route.meta.title}}</span></div>
		<router-view/>
	</app-content>
</template>

<script>
	export default {
		name: "TemplateIndex"
	}
</script>

<style scoped>

</style>