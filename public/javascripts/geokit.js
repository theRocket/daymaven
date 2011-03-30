var map;
var bounds;

$(function () {
	$('#city').search_location_autocomplete();
	});
	

$(function () {
	$('#day_location').day_location_autocomplete();
	});

$(function () {
	var latlng = new google.maps.LatLng(57.8, 14.0);
	
	var options = {
	  zoom: 6,
	  center: latlng,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	}; 
	
	map = new google.maps.Map(document.getElementById('map'), options);
		
	bounds = new google.maps.LatLngBounds();

	google.maps.event.addListener(map, 'zoom_changed', function() {
        zoomChangeBoundsListener = google.maps.event.addListener(map, 'bounds_changed', function(event) {
            if (this.getZoom() > 12) // Change max/min zoom here
                this.setZoom(12);
               
            google.maps.event.removeListener(zoomChangeBoundsListener);
        });
	}); 
});

function add_marker(lat, lng, title, url)
{
	var latlng = new google.maps.LatLng(lat, lng);
	var marker = new google.maps.Marker({
        position: latlng, 
        map: map,
        title: title});
		
	var infowindow = new google.maps.InfoWindow({
        content: "test content"
    });
	
	google.maps.event.addListener(marker, 'click', function() {
      location.href = url
    });

		
	bounds.extend(latlng);
};

function center_and_bound_map()
{
	map.fitBounds(bounds);
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

				add_marker(ui.item.lat, ui.item.lng, 'Location');
				center_and_bound_map();				
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
				add_marker(ui.item.lat, ui.item.lng, ui.item.title);
				center_and_bound_map()				
            },

            open: function(event, ui) {
                $('.ui-autocomplete').css('z-index', '9999');
                $('.ui-autocomplete').css('width', $(event.target).outerWidth());
            }
        });
    });
}







