optimize								=	{
	svg									:	function(){
		$('img[src$=".svg"]').each(function() {
			var $img 					=	jQuery(this);
			var imgURL 					=	$img.attr('src');
			var attributes 				=	$img.prop("attributes");
  
			$.get(imgURL, function(data) {
		  		var $svg 				=	jQuery(data).find('svg');
		  		$svg 					=	$svg.removeAttr('xmlns:a');
		  		$.each(attributes, function() {
					$svg.attr(this.name, this.value);
		  		});
		  		$img.replaceWith($svg);
			}, 'xml');
	  	});
	}
}
