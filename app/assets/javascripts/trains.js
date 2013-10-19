// function trains(map) {
//   $.get('/trains', function(response){

//     console.log(response.ctatt);
//     response.ctatt.route[0].train[0].lat.$
//     $.each(response.ctatt.route,function(index, value){
//       $.each(value.train,function(index, val){
//         trainMarker(val.lat.$, val.lon.$, map);
//       })
//     })
//     // var xmlTrains = $.parseXML( response[0] ),
//     //   $xml = $( xmlTrains ),
//     //   $train = $xml.find( "train" );
//     // var trains = response[0].getElementsByTagName("train");
//     // console.log(result);
//     // $.each(response, function(index, value){

//     //
//     // });
//   });
// };

function trainMarker(lat, lon, map, line, val) {
  var latLng = new google.maps.LatLng(lat, lon);

  pics = ['http://i.picresize.com/images/2013/10/19/i4oAj.png','http://i.picresize.com/images/2013/10/19/hVDo.png','http://i.picresize.com/images/2013/10/19/NwQW.png','http://i.picresize.com/images/2013/10/19/5Jtbk.png','http://i.picresize.com/images/2013/10/19/Hl1uv.png','http://i.picresize.com/images/2013/10/19/JcLw.png','http://i.picresize.com/images/2013/10/19/LtVwe.png', 'http://i.picresize.com/images/2013/10/19/0rLaI.png']

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: pics[line],
  });
  var infoWindowOptions = {
    content:  val
  };
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  google.maps.event.addListener(marker,'click', function(e){
    infoWindow.open(map,marker);
  });
  removeMarker(marker);
}

function removeMarker(marker){
  setTimeout(function(){marker.setMap(null)},14750);
}

