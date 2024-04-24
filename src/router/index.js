import { createRouter, createWebHistory } from "vue-router";
import TVChartContainer from "@/components/TVChartContainer.vue";

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: "/",
			name: "home",
			component: TVChartContainer,
		},
	],
});

export default router;
