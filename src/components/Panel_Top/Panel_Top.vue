<template>
  <div id="panel-top">
    <div id="panel-top_left">
		<div id="panel-top_left_algoview-button" class="button">
			<img src="@/assets/icons/algoview.svg" alt="AV"/>
		</div>
		<div id="panel-top_left_algoview-title" class="panel-title">
			AlgoView
		</div>
	</div>
	<div id="panel-top_right">
		
	</div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import { usePanelTopStore } from '@/components/Panel_Top/Panel_Top.js';

export default {
  name: 'PanelTop',
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

    const panelTopStore = usePanelTopStore();

    // expose to template
    return {
      someData,
      someMethod,
      panelTopStore,
      // someComputed,
    };
  },
};
</script>

<style scoped>
#panel-top_left_algoview-button{
	width: calc(var(--panel-top-height) - var(--panel-padding-horizontal) * 2);
	height: calc(var(--panel-top-height) - var(--panel-padding-horizontal) * 2);
	margin-right: var(--panel-padding-horizontal);
}
.button img{
	width: 100%;
	height: 100%;
	border-radius: var(--panel-corner-radius);
}
.panel-title{
	font-size: var(--panel-title-font-size);
	font-weight: var(--panel-title-font-weight);
	font-family: var(--panel-title-font-family);
	width: 20rem;
	height: calc(var(--panel-top-height) - var(--panel-padding-horizontal) * 2);
	margin-left: var(--panel-spacing);
}
</style>