function setMarker(lat, lon, map, val) {
  console.log(lat, lon, map);
  var latLng = new google.maps.LatLng(lat, lon);

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: 'http://www.charlestonstems.com/wp-content/themes/stems/images/instagram_icon_22x22.png',
    animation: google.maps.Animation.BOUNCE,
  });
   setTimeout(function(){ marker.setAnimation(null); }, 750);
  var infoWindowOptions = {
    content:  val
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'click', function(e){
    infoWindow.open(map,marker);
  });

  setTimeout(function(){marker.setMap(null)},120000);

};

