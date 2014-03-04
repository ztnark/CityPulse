function getMarker(lat, lon, map, val) {
  var latLng = new google.maps.LatLng(lat, lon);

  function getCircle(size) {
    return {
      path: google.maps.SymbolPath.CIRCLE,
      fillColor: '#FF5757',
      fillOpacity: .5,
      scale: Math.pow(1.7, size) / Math.PI,
      strokeColor: 'red',
      strokeWeight: 0
    };
  }

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: 'http://eventful.com/favicon.ico'
  });
  var contentString = (val.title).link(val.url) + "<br>" + val.venue_name
  var infoWindowOptions = {
    content: contentString,
    maxWidth: 200
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'mouseover', function(e){
    infoWindow.open(map,marker);
  });
  google.maps.event.addListener(marker,'mouseout', function(e){
    infoWindow.close();
  });
  google.maps.event.addListener(marker,'click', function(e){
    window.open(val.url);
  });

  setTimeout(function(){marker.setMap(null)},180100);
};

