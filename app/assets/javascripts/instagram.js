function setMarker(lat, lon, map, val) {
  var latLng = new google.maps.LatLng(lat, lon);


  function getCircle(size) {
    return {
      path: google.maps.SymbolPath.CIRCLE,
      fillColor: 'blue',
      fillOpacity: .2,
      scale: Math.pow(2, size) / Math.PI,
      strokeColor: 'white',
      strokeWeight: .5
    };
  }



  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: 'http://icons.iconarchive.com/icons/designcontest/vintage/32/Camera-icon.png'
  });
  var infoWindowOptions = {
    content:  val
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'click', function(e){
    infoWindow.open(map,marker);
  });
};


function instagram(map) {
  $.post('/instagram', function(response){
    $.each(response, function(index, value){
      setMarker(value.latitude, value.longitude, map);
      console.log()
    });
  });
};

