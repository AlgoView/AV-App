windowx									    =	{
	rescale									:	function(){
        // command.log('windowx.rescale');
		// console.log('Shake Shake');

		// TOPLAYERS

		// tickerbar.commons.check();
		// barheader.commons.check();
		// toolbar.commons.check();

		// tickerbar.commons.set();
		// barheader.commons.set();
		// bartools.commons.set();


		// MIDLAYERS

		// panelleft.commons.check();
		// panelright.commons.check();


		// panelleft.commons.set();
		// panelright.commons.set();

	},
	placement								:	function(){}
}
window.onload = function() {
	setInterval(windowx.rescale, 1000);

	window.addEventListener('resize', function() {
		setTimeout(function() {
			device.set();
			windowx.rescale();
		}, fadelenght);
	});

	setTimeout(function() {
		windowx.rescale();
	}, fadelenght);
};