$.fn.location_autocomplete = function(settings) {
return this.each(function(){
console.log($(this));
$(this).autocomplete({
source: "/locations/",
delay: 500,
minLength: 2,
autoFocus: true,
open: function(event, ui) {
$('.ui-autocomplete').css('z-index', '9999');
$('.ui-autocomplete').css('width', $(event.target).outerWidth());
}
});
});
}


	


	