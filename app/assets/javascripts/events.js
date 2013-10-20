function getMarker(lat, lon, map, val) {
  var latLng = new google.maps.LatLng(lat, lon);

  function getCircle(size) {
    return {
      path: google.maps.SymbolPath.CIRCLE,
      fillColor: '#FF5757',
      fillOpacity: .23,
      scale: Math.pow(2, size) / Math.PI,
      strokeColor: 'red',
      strokeWeight: 0
    };
  }

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: getCircle(6)
  });
  var infoWindowOptions = {
    content:  val.title + "<br>"+ val.venue_name + "<br>" + val.start_time
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'click', function(e){
    infoWindow.open(map,marker);
  });
};

// function events(map) {

//     $.each(response, function(index, value){
//       getMarker(value.latitude, value.longitude, map, value);
//     });

// };
