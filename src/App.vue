<template>
	<div class="app">
		<TVChartContainer />
	</div>
</template>

<script setup>
import { RouterLink, RouterView } from "vue-router";
import TVChartContainer from "./components/TVChartContainer.vue";
import { version } from "../public/charting_library";
</script>

<style scoped src="@/assets/css/main.css"></style>
<style scoped>
.app {
}
</style>
