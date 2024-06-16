<template>
  <div id="panel-top" class="panel">
    <div id="panel-top_platform-button" class="button">
		<img src="@/assets/icons/algoview.svg" alt="AV"/>
	</div>
	<div id="panel-top_platform-title" class="panel-title">
			AlgoView
	</div>
	<div id="panel-top_user-button" class="button">
		user
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
</style>