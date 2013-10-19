function trains(map) {
  $.get('/trains', function(response){
    console.log(response[2]);
    var result = response[0].getElementsByTagName("train")[0];
    // console.log(result);
    // $.each(response, function(index, value){

    //   getMarker(value.latitude, value.longitude, map, value);
    // });
  });
};