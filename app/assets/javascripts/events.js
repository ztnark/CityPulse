function setMarker(lat, lon, map, val) {
  var latLng = new google.maps.LatLng(lat, lon);

  function getCircle(size) {
    return {
      path: google.maps.SymbolPath.CIRCLE,
      fillColor: 'red',
      fillOpacity: .2,
      scale: Math.pow(2, size) / Math.PI,
      strokeColor: 'white',
      strokeWeight: .5
    };
  }

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: getCircle(6)
  });
  var infoWindowOptions = {
    content:  val.title + "<br>"+ val.venue_name
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'click', function(e){
    infoWindow.open(map,marker);
  });
};

function events(map) {
  $.post('/eventful', function(response){
    $.each(response, function(index, value){
      setMarker(value.latitude, value.longitude, map, value);
    });
  });
};
