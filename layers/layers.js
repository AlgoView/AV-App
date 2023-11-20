class Layer 									{
    constructor(layername) 									{
        this.layername 										=	"layers-" + layername;
	}
	properties												=	{
		element												:	{
			type											:	'',
			subtype											:	undefined
		},
		placement											:	{
			to												:	undefined,		// Top 		// Bottom	// Left		// Right
			z												:	undefined, 		// Highest to Lowest	// Edge High to Center Low
			state											:	undefined,		// Solid 	// Liquid 	// gas		// plasma

			dimensions										:	{				// OPPOSING TO AXIS = PREDEFINED CONSTANT IN REM	// ON AXIS IS CONSTANT OR VARIABLE IN VX
				height										:	undefined,		// x.xx REM or xxx vh/vw
				width										:	undefined		// x.xx REM or xxx vh/vw
			},
			margin											:	{
				top											:	undefined,		// x.xx REM
				bottom										:	undefined,		// x.xx REM
				left										:	undefined,		// x.xx REM
				right										:	undefined		// x.xx REM
			},
			padding											:	{
				top											:	undefined,		// x.xx REM
				bottom										:	undefined,		// x.xx REM
				left										:	undefined,		// x.xx REM
				right										:	undefined		// x.xx REM
			}
		},
		interact 											:	{
			status											:	undefined,
			select 											:	function(){
				console.log('select');
			},
			unselect 										:	function(){
			},
			focus 											:	function(){
			},
			unfocus 										:	function(){
			}
		},
		visibility											:	{
			status											:	undefined,
			show											:	() => {
				this.properties.visibility.status 			=	true;
				console.log(this.layername);
				let element 								=	document.getElementById(this.layername);
				console.log(element);
				element.style.display 						=	'block';
				element.classList.add('fade-in');
				windowx.rescale();
			},
			hide											:	() => {
				this.properties.visibility.status 			=	false;
				let element 								=	document.getElementById(this.layername);
				element.style.display 						=	'none';
				element.classList.add('fade-out');
				windowx.rescale();
			},
			toggle											:	function(){
				switch (this.status){
					case undefined							:	console.log('visibility status undefined');
					case true								:	this.hide(); break;
					case false								:	this.show(); break;
				}
			},
			minimize										:	function(){
				this.visibility.status 						=	'none';
				document.documentElement.style.setProperty('--' + this.layername + '-visibility-', this.visibility.status);
			},
			maximize										:	function(){
				this.visibility.status 						=	'block';
				document.documentElement.style.setProperty('--' + this.layername + '-visibility-', this.visibility.status);
			}
		}
	}
};

window.layers  												=	{
	isValidKey												:	function(key) {
		const EXCLUDED_KEYS 								=	["isValidKey","properties","getData","get","set","render","layername"];
		return !EXCLUDED_KEYS.includes(key);
	},
	get														:	function(){
		let self 											=	this;
		let ajaxcalls 										=	[];
		for(let layer in index.construct.data.layers){
			layers[layer] 									=	new Layer(layer);
		}
		return new Promise((resolve, reject) => {
            Object.keys(self).forEach(layer => {
                if(self.isValidKey(layer)){
                    let ajaxCall = fetch('layers/' + layer + '/' + layer + '.json')
                        .then(response => response.json())
						.then(data => {
							Object.keys(data).forEach((key) => {
								if (key === 'properties' && data[key] instanceof Object) {
									Object.keys(data[key]).forEach((propKey) => {
										if (!layers[layer].properties.hasOwnProperty(propKey)) {
											layers[layer].properties[propKey] = data[key][propKey];
										}
									});
								} else if (!layers[layer].hasOwnProperty(key)) {
									layers[layer][key] = data[key];
								}
							});
							return layer;
						});

                    ajaxcalls.push(ajaxCall);
                }
            });
	
			Promise.all(ajaxcalls)

			.then(() => {resolve('layers.set()');
		})
            .catch(() => reject());
		});              
	},
	render													:	function(){
		const layerRoot 									=	layers;

		function createDiv(id) {
			let div 										=	document.createElement('div');
			div.id 											=	id;
			div.style.display 								=	'none';
			return div;
		}

		let rootDiv 										=	createDiv('layers');

		for(let layer in layerRoot) {
			if (this.isValidKey(layer)) {
				let layerDiv 								=	createDiv('layers-' + layer);
				rootDiv.appendChild(layerDiv);

				for(let sublayer in layerRoot[layer]) {
					if (this.isValidKey(sublayer)) {
						let sublayerDiv 					=	createDiv('layers-' + layer + '-' + sublayer);
						layerDiv.appendChild(sublayerDiv);

						for(let subsublayer in layerRoot[layer][sublayer]) {
							if (this.isValidKey(subsublayer)) {
								let subsublayerDiv 			=	createDiv('layers-' + layer + '-' + sublayer + '-' + subsublayer);
								sublayerDiv.appendChild(subsublayerDiv);
							}
						}
					}
				}
			}
		}

		document.body.appendChild(rootDiv);
		index.body.construct.status = true;
	}
};
