<template>
	<div id="panel-center">
		<PanelCenterLeft />
		<PanelCenterRight />
	</div>
</template>

<script>
import { ref, onMounted } from "vue";

import { usePanelCenterStore } from "@/components/Panel_Center/Panel_Center.js";

import PanelCenterLeft from "@/components/Panel_Center/Panel_Center_Left.vue";
import PanelCenterRight from "@/components/Panel_Center/Panel_Center_Right.vue";

export default {
	name: "PanelCenter",
	components: {
		PanelCenterLeft,
		PanelCenterRight,
	},
	setup() {
		// replace data properties with ref or reactive
		const someData = ref(null); // example

		// replace methods with functions
		const someMethod = () => {
			// Your method logic goes here
		};

		// replace computed with computed
		// const someComputed = computed(() => /* Your logic here */);

		onMounted(() => {
			// Code to run when the component is mounted
		});

		const panelCenterStore = usePanelCenterStore();

		// expose to template
		return {
			someData,
			someMethod,
			panelCenterStore,
			// someComputed,
		};
	},
};
</script>

<style scoped>

</style>
