<template>
	<Panel_Top />
	<Panel_Center />
	<Panel_Bottom />
</template>

<script setup>
import { RouterLink, RouterView } from "vue-router";

import Panel_Top from "@/components/Panel_Top/Panel_Top.vue";
import Panel_Center from "@/components/Panel_Center/Panel_Center.vue";
import Panel_Bottom from "@/components/Panel_Bottom/Panel_Bottom.vue";
</script>

<style scoped src="@/assets/css/main.css"></style>
<style scoped>

</style>
