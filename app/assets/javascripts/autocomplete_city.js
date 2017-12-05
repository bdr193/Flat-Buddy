function onPlaceChanged() {
 var place = this.getPlace();
 var lat = place.geometry.location.lat();
 var lng = place.geometry.location.lng();

 document.getElementById('search_lat').setAttribute('value', lat);
 document.getElementById('search_lng').setAttribute('value', lng);

 var flatAddress = document.getElementById('search_city');
 flatAddress.blur();
}

document.addEventListener("DOMContentLoaded", function() {
 var flatAddress = document.getElementById('search_city');

 if (flatAddress) {
   var autocomplete = new google.maps.places.Autocomplete(flatAddress, { types: ['geocode'] });
   google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
   google.maps.event.addDomListener(flatAddress, 'keydown', function(e) {
     if (e.key === "Enter") {
       e.preventDefault(); // Do not submit the form on Enter.
     }
   });
 }
});
