function briteMarker(lat, lon, map, val) {
  var latLng = new google.maps.LatLng(lat, lon);

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: 'http://i.picresize.com/images/2013/11/14/dESpR.png'
  });

  var contentString = (val.title).link(val.url) + "<br>" + val.venue + "<br>at " + val.at_time
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
