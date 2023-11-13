class Layer 												{
    constructor(__layername)								{
		this.properties										=	{
			// status											:	undefined,
			element											:	{
				type										:	'',
				subtype										:	undefined
			},
			placement										:	{
				to											:	undefined,		// Top 		// Bottom	// Left		// Right
				z											:	undefined, 		// Highest to Lowest	// Edge High to Center Low
				state										:	undefined,		// Solid 	// Liquid 	// gas		// plasma
	
				dimensions									:	{				// OPPOSING TO AXIS = PREDEFINED CONSTANT IN REM	// ON AXIS IS CONSTANT OR VARIABLE IN VX
					height									:	undefined,		// x.xx REM or xxx vh/vw
					width									:	undefined		// x.xx REM or xxx vh/vw
				},
				margin										:	{
					top										:	undefined,		// x.xx REM
					bottom									:	undefined,		// x.xx REM
					left									:	undefined,		// x.xx REM
					right									:	undefined		// x.xx REM
				},
				padding										:	{
					top										:	undefined,		// x.xx REM
					bottom									:	undefined,		// x.xx REM
					left									:	undefined,		// x.xx REM
					right									:	undefined		// x.xx REM
				}
			},
			interact 										:	{
				status										:	undefined,
				select										:	function(){
				},
				unselect									:	function(){
				},
				focus										:	function(){
				},
				unfocus										:	function(){
				}
			},
			visibility										: {
				status										: undefined,
				show										: function(){
					this.status 							= true;
					let element 							= document.getElementById(__layername);
					element.style.display 					= 'block';
					element.classList.add('fade-in');
					windowx.rescale();
				},
				hide										: function(){
					this.status 							= false;
					let element 							= document.getElementById(__layername);
					element.style.display 					= 'none';
					element.classList.add('fade-out');
					windowx.rescale();
				},
				toggle										: function(){
					switch (this.status){
						case undefined						: console.log('visibility status undefined');
						case true							: this.hide(); break;
						case false							: this.show(); break;
					}
				},
				minimize: function(){
					this.visibility.status 					= 'none';
					document.documentElement.style.setProperty('--' + __layername + '-visibility-', this.visibility.status);
				},
				maximize: function(){
					this.visibility.status 					= 'block';
					document.documentElement.style.setProperty('--' + __layername + '-visibility-', this.visibility.status);
				}
			}
		};
    };
};

var layers 													= {
	isValidKey												: function(key) {
		const EXCLUDED_KEYS 								= ["isValidKey","properties","getData","get","set","render"];
		return !EXCLUDED_KEYS.includes(key);
	},
    getData													: {},
	get														: function(){
		let self 											= this;
		let ajaxcalls 										= [];
		return new Promise((resolve, reject) => {
			Object.keys(self).forEach(layer => {
				if(self.isValidKey(layer)){
					let ajaxCall 							= fetch('layers/' + layer + '/' + layer + '.json')
						.then(response => response.json())
						.then(data => {
							self.getData[layer] 			= data;
							return layer;
						});
	
					ajaxcalls.push(ajaxCall);
				}
			});
	
			Promise.all(ajaxcalls)
				.then(() => resolve('layers.set()'))
				.catch(() => reject());
		});              
	},
	set														: function(){
		Object.keys(layers).forEach(layer => {
			if(this.isValidKey(layer)){
				layers[layer] 								= new Layer(layer);
			}
		});

		Object.assign(layers, layers.getData);
	},
	render													: function(){
		const layerRoot 									= layers;

		function createDiv(id) {
			let div 										= document.createElement('div');
			div.id 											= id;
			div.style.display 								= 'none';
			return div;
		}

		let rootDiv 										= createDiv('layers');

		for(let layer in layerRoot) {
			if (this.isValidKey(layer)) {
				let layerDiv 								= createDiv('layers-' + layer);
				rootDiv.appendChild(layerDiv);

				for(let sublayer in layerRoot[layer]) {
					if (this.isValidKey(sublayer)) {
						let sublayerDiv 					= createDiv('layers-' + layer + '-' + sublayer);
						layerDiv.appendChild(sublayerDiv);

						for(let subsublayer in layerRoot[layer][sublayer]) {
							if (this.isValidKey(subsublayer)) {
								let subsublayerDiv 			= createDiv('layers-' + layer + '-' + sublayer + '-' + subsublayer);
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
