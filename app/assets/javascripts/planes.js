
function planeMarker(lat, lon, map, val) {
  var latLng = new google.maps.LatLng(lat, lon);

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: "http://i.picresize.com/images/2013/10/21/xv2Fm.png"
  });
  var infoWindowOptions = {
    content:  val,
    maxWidth: 200
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'mouseover', function(e){
    // console.log(e);
    // $('.gm-style-iw').close();
    infoWindow.open(map,marker);
  });
  google.maps.event.addListener(marker,'mouseout', function(e){
    // console.log(e);
    // $('.gm-style-iw').close();
    infoWindow.close();
  });
  removeMarker(marker);
}

function removeMarker(marker){
  setTimeout(function(){marker.setMap(null)},14750);
}
