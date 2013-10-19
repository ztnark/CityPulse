function trains(map) {
  $.get('/trains', function(response){
    console.log(response[2]);
    var redTrains    = response[0].getElementsByTagName("train");
    var greenTrains  = response[1].getElementsByTagName("train");
    var blueTrains   = response[2].getElementsByTagName("train");
    var brownTrains  = response[3].getElementsByTagName("train");
    var pinkTrains   = response[4].getElementsByTagName("train");
    var orangeTrains = response[5].getElementsByTagName("train");
    var purpleTrains = response[6].getElementsByTagName("train");
    var yellowTrains = response[7].getElementsByTagName("train");
    // console.log(result);
    // $.each(response, function(index, value){

    //   getMarker(value.latitude, value.longitude, map, value);
    // });
  });
};