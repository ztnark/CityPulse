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

function trainMarker(lat, lon, map) {
  var latLng = new google.maps.LatLng(lat, lon);


  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: 'http://i.picresize.com/images/2013/10/19/W4Z7P.png',
  });
}
