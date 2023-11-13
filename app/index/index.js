index												=	{
	placement										:	{
		status										:	undefined,
		data										:	undefined,
		to											:	undefined,		// Top 		// Bottom	// Left		// Right
		z											:	undefined, 		// Highest to Lowest	// Edge High to Center Low
		state										:	undefined,		// Solid 	// Liquid 	// gas		// plasma

		dimensions									:	{				// OPPOSING TO AXIS = PREDEFINED CONSTANT IN REM	// ON AXIS IS CONSTANT OR VARIABLE IN VX
			height									:	function(__layername){},
			width									:	function(__layername){}
		},
		margin										:	{
			top										:	function(to,z,state){},
			bottom									:	function(to,z,state){},
			left									:	function(to,z,state){},
			right									:	function(to,z,state){}
		},
		padding										:	{
			top										:	function(to,z,state){},
			bottom									:	function(to,z,state){},
			left									:	function(to,z,state){},
			right									:	function(to,z,state){}
		},
	},
	commons											:	{
		topmargin									:	function(layer){
			if ( bartickers.commons.height === undefined ) {
				bartickers.commons.height = 0;
			}
			if ( barheader.commons.height === undefined ) {
				barheader.commons.height = 0;
			}
			if ( bartools.commons.height === undefined ) {
				bartools.commons.height = 0;
			}

			switch(layer) {
				case 'bartickers':
				
				return 0;
				case 'barheader':
					if ( bartickers.visibility.status == true ){
						return ( bartickers.commons.height );
					} else {
						return ( 0 );
					}
				case 'bartools':
					if ( bartickers.visibility.status == true ){
						if ( barheader.visibility.status == true ){
							return ( bartickers.commons.height + barheader.commons.height ) ;
						} else {
							return ( bartickers.commons.height );
						}
					} else {
						if ( barheader.visibility.status == true ){
							return ( barheader.commons.height ) ;
						} else {
							return ( 0 );
						}
					}
				case 'layunder':
				if ( bartickers.visibility.status == true ){
					if ( barheader.visibility.status == true ){
						if ( bartools.visibility.status == true ){
							return ( bartools.commons.height + bartickers.commons.height + barheader.commons.height ) ;
						} else {
							return ( bartickers.commons.height + barheader.commons.height);
						}
					} else {
						if ( bartools.visibility.status == true ){
							return ( bartools.commons.height + bartickers.commons.height) ;
						} else {
							return ( bartickers.commons.height);
						}
					}
				} else {
					if ( barheader.visibility.status == true ){
						if ( bartools.visibility.status == true ){
							return ( bartools.commons.height + barheader.commons.height ) ;
						} else {
							return ( barheader.commons.height);
						}
					} else {
						if ( bartools.visibility.status == true ){
							return ( bartools.commons.height ) ;
						} else {
							return ( 0 );
						}
					}
				}
				default:
				return 0;
			}
		}
	},
	construct										:	{
		status										:	false,
		data										:	undefined,
		get											:	function(){
			let getdata								=	$.ajax({
				url									:	'/app/index/index.json',
				dataType							:	'json',
				type								:	'GET',
				success								:	function(){
					index.construct.data			=	getdata.responseJSON;
				}
			})
			return getdata;
		},
		build										:	async function(){
			index.head.construct.build();
			index.body.construct.build();
		},
		destroy										:	function(){
			index.head.construct.destroy();
			index.body.construct.destroy();
		}
	},
	head										:	{
		construct								:	{
			status								:	false,
			data								:	undefined,
			get									:	function(){
				index.construct.get();
			},
			build								:	function(){
				var append						=	'';
				append							+=
				'<!-- 𝗧𝗜𝗧𝗟𝗘 -->' +
				'<title>' + index.construct.data.title + '</title>';

				append							+=
				'<!-- 𝗠𝗘𝗧𝗔 -->';
				for(var i in index.construct.data.meta){
					name						=	i;
					layunder						=	index.construct.data.meta[i];
					append						+=
					'<meta 	name="' + name + '"							layunder="' + layunder + '">';
				}

				append							+=
				'<!-- 𝗠𝗢𝗗𝗨𝗟𝗘𝗦 -->';
				for(var i in index.construct.data.modules){
					name						=	i;
					layunder						=	index.construct.data.modules[i];
					append						+=
					'<script	rel="external"		type="text/javascript"	src="modules/' + name + '.js"></script>';
				}

				append							+=
				'<!-- 𝗦𝗧𝗬𝗟𝗜𝗡𝗚 -->';
				for(var i in index.construct.data.styling){
					name						=	i;
					layunder						=	index.construct.data.styling[i];
					append						+=	'<link	rel="stylesheet"		type="text/css"	href="styling/' + name + '.css"></link>';
				}

				append							+=
				'<!-- 𝗘𝗟𝗘𝗠𝗘𝗡𝗧𝗦 -->';
				append							+=
				'<script	rel="external"		type="text/javascript"	src="elements/elements.js"></script>';
				for(var i in index.construct.data.elements){
					name						=	i;
					layunder						=	index.construct.data.elements[i];
					append						+=
					'<link	rel="stylesheet"		type="text/css"	href="elements/' + name + '/' + name + '.css"></link>'	+
					'<script	rel="external"		type="text/javascript"	src="elements/' + name + '/' + name + '.js"></script>';
				}

				append							+=
				'<!-- 𝗟𝗔𝗬𝗘𝗥𝗦 -->'+
				'<script	rel="external"		type="text/javascript"	src="layers/layers.js"></script>';
				for(var i in index.construct.data.layers){
					name 						=	i;
					layunder 					=	index.construct.data.layers[i];
					append						+=
					'<!-- ' + text.toBold(name.toUpperCase()) + ' -->'+
					'<script	rel="external"		type="text/javascript"	src="layers/' + name + '/' + name + '.js"></script>';
				}
				$('head').append(append);
				return
			},
			destroy								:	function(){
			}
		}
	},
	body										:	{
		construct								:	{
			status								:	false,
			data								:	undefined,
			get									:	function(){
				index.construct.get();
			},
			build								:	function(){
				var append						=	'';

				for(var i in index.construct.data.scripts){
					script						=	index.construct.data.scripts[i]
					let title					=	(i + '/' + script).toUpperCase();
					append						+=
					'<!-- ' + title + ' -->' +
					'<script type="text/javascript" src="' + i + '/' + script + '.js" defer>' +
					'</script>';
				}

				$('body').append(append);
				index.body.construct.status		=	true;
			},
			destroy								:	function (){
			}
		}
	}
}