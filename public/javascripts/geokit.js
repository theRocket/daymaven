var map;
var create_day_marker;

var bounds;

$(function () {
	$('#city').search_location_autocomplete();
	});
	

$(function () {
	$('#day_location').day_location_autocomplete();
	});

$(function () {
	var latlng = new google.maps.LatLng(48.7, -122.4);
	
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
	
	google.maps.event.addListener(marker, 'click', function() {
      location.href = url
    });

		
	bounds.extend(latlng);
};

function add_create_day_marker(lat, lng, title)
{
	var latlng = new google.maps.LatLng(lat, lng);
	
	//clean out existing marker and bounds if we have one (only 1 allowed on create day
	if (create_day_marker)
	{
		create_day_marker.setMap(null);	
		bounds = new google.maps.LatLngBounds();
	}
	
	create_day_marker = new google.maps.Marker({
        position: latlng, 
        map: map,
        title: title, draggable:true});
		
	bounds.extend(latlng);

	google.maps.event.addListener(create_day_marker, 'dragend', function() {
	create_day_marker.getPosition()
	$("#day_latitude").val(create_day_marker.getPosition().lat());
				$("#day_longitude").val(create_day_marker.getPosition().lng());
  });


}

function center_and_bound_map()
{
	map.fitBounds(bounds);
};

$.fn.day_location_autocomplete = function(settings) {
    return this.each(function() {
        console.log($(this));
        $(this).autocomplete({
            source: "/locations/",
            delay: 300,
            minLength: 2,
            autoFocus: true,
            select: function(event, ui) {		
				$("#day_latitude").val(ui.item.lat);
				$("#day_longitude").val(ui.item.lng);

				add_create_day_marker(ui.item.lat, ui.item.lng, 'Drag me to to your spot or day!');
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
       
        $(this).autocomplete({
            source: "/locations/",
            delay: 300,
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







