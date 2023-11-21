const appendHTML = (type, attributes) => {
    let html = '';
    switch (type) {
        case 'category':
            html += `<!-- ${attributes} -->`;
            break;
        case 'title':
            html += `<title>${attributes.title}</title>`;
            break;
        case 'meta':
            html += `<meta name="${attributes.name}" layunder="${attributes.layunder}">`;
            break;
        case 'script':
            html += `<script rel="external" type="text/javascript" src="${attributes.src}"></script>`;
            break;
        case 'link':
            html += `<link rel="stylesheet" type="text/css" href="${attributes.href}"></link>`;
            break;
    }
    return html;
};

const constructCategory = (category, data, fileType = 'both', groupType = '') => {
	let element;
	let comment = document.createComment(` ${category} `);
	document.head.appendChild(comment);

	if (category === 'title') {
		element = document.createElement('title');
		element.textContent = data;
		document.head.appendChild(element);
	} else {
		if (groupType === 'grouped') {
			element = document.createElement('script');
			element.src = `${category}/${category}.js`;
			document.head.appendChild(element);
		}
		for (let name in data) {
			if (category === 'meta') {
				element = document.createElement('meta');
				element.name = name;
				element.content = data[name];
				document.head.appendChild(element);
			} else {
				if (groupType === 'grouped'){
					if (fileType === 'both' || fileType === 'js') {
						element = document.createElement('script');
						element.src = `${category}/${name}/${name}.js`;
						document.head.appendChild(element);
					}
					if (fileType === 'both' || fileType === 'css') {
						element = document.createElement('link');
						element.rel = 'stylesheet';
						element.href = `${category}/${name}/${name}.css`;
						document.head.appendChild(element);
					}
				} else {
					if (fileType === 'both' || fileType === 'js') {
						element = document.createElement('script');
						element.src = `${category}/${name}.js`;
						document.head.appendChild(element);
					}
					if (fileType === 'both' || fileType === 'css') {
						element = document.createElement('link');
						element.rel = 'stylesheet';
						element.href = `/${category}/${name}.css`;
						document.head.appendChild(element);
					}
				}
			}
		}
	}
};

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

		get											:	function() {
			return fetch('/app/index/index.json')
				.then(response => response.json())
				.then(data => {
					index.construct.data = data;
					return data;
				});
		},
		build										:	async function(){
			index.head.construct.build();
			index.body.construct.build();

			index.construct.status					=	true;
			return
		}
	},
	head											:	{
		construct									:	{
			status									:	false,
			data									:	undefined,
			get										:	function(){
				index.construct.get();
			},
			build									:	async function() {
				constructCategory('title', index.construct.data.title);
				constructCategory('meta', index.construct.data.meta);
				constructCategory('modules', index.construct.data.modules, 'js');
				constructCategory('styling', index.construct.data.styling, 'css');
				constructCategory('elements', index.construct.data.elements, 'both', 'grouped');
				constructCategory('layers', index.construct.data.layers, 'both', 'grouped');

				index.head.construct.status			=	true;
				return;
			}
		}
	},
	body											:	{
		construct									:	{
			status									:	false,
			data									:	undefined,
			get										:	function(){
				index.construct.get();
			},
			build									:	async function(){
				constructCategory('scripts', index.construct.data.scripts, 'js');

				index.body.construct.status			=	true;
				return
			}
		}
	}
}