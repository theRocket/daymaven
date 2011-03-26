var map


function initialize() 
{
	if (GBrowserIsCompatible()) 
	{
		map = new GMap2(document.getElementById("map"));
		map.setCenter(new GLatLng(48.76152, -122.4978133), 13);
		map.setUIToDefault();
							map.enableGoogleBar();
							


var myEventListener = GEvent.bind(map, "click", this, function(overlay, latlng) 
									{
															if (latlng) 
															{
																 map.addOverlay(new GMarker(latlng))
															} 

												}); 


	}
}

$.fn.location_autocomplete = function(settings) {
return this.each(function(){
console.log($(this));
$(this).autocomplete({
source: "/locations/",
delay: 500,
minLength: 2,
autoFocus: true,
select: function(event, ui) {
		var point = new GLatLng(ui.item.lat, ui.item.lng);
					map.addOverlay(new GMarker(point));
						map.setCenter(new GLatLng(ui.item.lat, ui.item.lng), 12);
					
},
	  
open: function(event, ui) {
$('.ui-autocomplete').css('z-index', '9999');
$('.ui-autocomplete').css('width', $(event.target).outerWidth());
}
});
});
}




	


	