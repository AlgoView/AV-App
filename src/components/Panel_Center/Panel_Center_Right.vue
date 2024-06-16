<template>
	<div id="panel-center_right">
		<div id="panel-center_right_top">
			<div class="trim-r"></div>
			<div class="cont-l"></div>
		</div>
		<div id="panel-center_right_center">
			<div class="trim-r"></div>
			<div id="panel-center_right_center-content">
				<div id="panel-center_right_center-content-content">
				</div>
			</div>
			<div id="panel-center_right_center-right"></div>
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
.trim-r {
	background-color: var(--tv-color-pane-background);
	border-radius: 0 var(--panel-corner-radius) var(--panel-corner-radius) 0;
	height:100%;
	width: var(--panel-spacing);
}
.cont-l {
	background-color: var(--tv-color-pane-background);
	border-radius:  var(--panel-corner-radius) 0 0 var(--panel-corner-radius);
	height:100%;
	width: 100%;
}
#panel-center_right_center-content {
	box-sizing: border-box;
	background-color: var(--tv-color-platform-background);
	height:100%;
	width: calc(100% - var(--panel-spacing));
	
}
#panel-center_right_center-content-content {
	background-color: var(--tv-color-pane-background);
	border-radius: var(--panel-corner-radius);
	height:100%;
	width: 100%;
}

#panel-center_right_center-right {
	background-color: var(--tv-color-pane-background);
	border-radius: var(--panel-corner-radius) 0  0 var(--panel-corner-radius);
	height:100%;
	width: 100%;
	justify-self: end;
}
</style>