<template>
	<div id="panel-center_right">
		<div id="panel-center_right_top" class="panel right">
		</div>
		<div id="panel-center_right_center">
			<div id="panel-center_right_center_left" class="panel center">
			</div>
			<div id="panel-center_right_center_right" class="panel right">
			</div>
		</div>
	</div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
	name: "PanelCenterRight",
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

		// const panelCenterStore = usePanelCenterStore();

		// expose to template
		return {
			someData,
			someMethod,
			// panelCenterStore,
			// someComputed,
		};
	},
};
</script>

<style scoped>

</style>