<script setup>
import { RouterLink, RouterView } from "vue-router";
import TVChartContainer from "./components/TVChartContainer.vue";
import { version } from "../public/charting_library";
</script>

<template>
	<div class="app">
		<TVChartContainer />
	</div>
</template>

<style scoped>
.app {
}
</style>
