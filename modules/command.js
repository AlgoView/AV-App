command 							=	{
	big								:	function(message){
		console.log('%c' + message + '',' color: grey; font-size:26px; font-weight:700; font-family:sans-serif;');
	},
	sub								:	function(message){
		console.log('%c' + message + '',' color: lightgrey; font-size:18px; font-weight:700; font-family:sans-serif;');
	},
	hid								:	function(message){
		console.log('%c' + message + '',' color: white; font-size:14px; font-weight:700; font-family:sans-serif;');
	},
	log								:	function(message){
		console.log('%c' + message + '',' color: lightgrey; font-size:14px; font-weight:700; font-family:sans-serif;');
	},
	blu								:	function(message){
		console.log('%c' + message + '',' color: azure; font-size:14px; font-weight:700; font-family:sans-serif;');
	}
}