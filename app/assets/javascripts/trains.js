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

  pics = ['http://i.minus.com/i0Z9qdPy5IU2s.png','http://i.minus.com/iQYEMTvag7M9M.png','http://i.minus.com/i9HL1ZvZtUxY5.png','http://i.minus.com/ibhqt7KRLhLcvy.png','http://i.minus.com/ibr37gQx3MaLRa.png','http://i.minus.com/ibjvmM2q09xH51.png','http://i.minus.com/inig7zodNJGHU.png', 'http://i.minus.com/i86yX9RMFh2zo.png']

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: pics[line],
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

