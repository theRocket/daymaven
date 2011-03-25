var map


function initialize() 
{
	if (GBrowserIsCompatible()) 
	{
		map = new GMap2(document.getElementById("map"));
		map.setCenter(new GLatLng(48.76152, -122.4978133), 13);
		map.setUIToDefault();
							map.enableGoogleBar();
							

			var point = new GLatLng(48.76152, -122.4978133);
							map.addOverlay(new GMarker(point));

var myEventListener = GEvent.bind(map, "click", this, function(overlay, latlng) 
									{
															if (latlng) 
															{
																 map.addOverlay(new GMarker(latlng))
															} 

												}); 


	}
}



  
