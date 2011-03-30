var map;

$(function () {
	$('#city').search_location_autocomplete();
	});
	

$(function () {
	$('#day_location').day_location_autocomplete();
	});

$(function () {

    if (GBrowserIsCompatible())
    {
        map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(48.76152, -122.4978133), 13);
        map.setUIToDefault();
        map.enableGoogleBar();

        var myEventListener = GEvent.bind(map, "click", this,
        function(overlay, latlng)
        {
            if (latlng)
            {
                map.addOverlay(new GMarker(latlng));
            }

        });


    }
});

function add_marker(lat, lng)
{
	var point = new GLatLng(lat, lng);
	map.addOverlay(new GMarker(point));
	map.setCenter(new GLatLng(lat, lng), 12);
};

$.fn.day_location_autocomplete = function(settings) {
    return this.each(function() {
        console.log($(this));
        $(this).autocomplete({
            source: "/locations/",
            delay: 500,
            minLength: 2,
            autoFocus: true,
            select: function(event, ui) {		
				$("#day_latitude").val(ui.item.lat);
				$("#day_longitude").val(ui.item.lng);

				add_marker(ui.item.lat, ui.item.lng);		          
            },

            open: function(event, ui) {
                $('.ui-autocomplete').css('z-index', '9999');
                $('.ui-autocomplete').css('width', $(event.target).outerWidth());
            }
        });
    });
}

$.fn.search_location_autocomplete = function(settings) {
    return this.each(function() {
        console.log($(this));
        $(this).autocomplete({
            source: "/locations/",
            delay: 500,
            minLength: 2,
            autoFocus: true,
            select: function(event, ui) {
				add_marker(ui.item.lat, ui.item.lng);	
            },

            open: function(event, ui) {
                $('.ui-autocomplete').css('z-index', '9999');
                $('.ui-autocomplete').css('width', $(event.target).outerWidth());
            }
        });
    });
}







