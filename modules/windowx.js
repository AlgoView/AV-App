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
$(function(){
	setInterval(windowx.rescale(), 1000);
	});

	$(windowx).resize(function() {
		setTimeout(function(){
			device.set();
			windowx.rescale();
		}, fadelenght);
	});
	$(windowx).ready(function(){
		setTimeout(function(){
			windowx.rescale();
		}, fadelenght);
	});