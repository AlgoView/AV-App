<template>
	<div id="panel-center_left">
			<TVChartContainer />
			<div id="panel-center_left_right">
				<div id="panel-center_left_right_top" class="panel left"></div>
				<div id="panel-center_left_right_center" class="panel left"></div>
			</div>
	</div>
</template>

<script>
import { ref, onMounted } from "vue";
import { usePanelCenterStore } from "@/components/Panel_Center/Panel_Center.js";

import TVChartContainer from "@/components/Panel_Center/TVChartContainer.vue";
import { version } from "@public/charting_library";

export default {
	name: "PanelCenterLeft",
	components: {
		TVChartContainer,
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
