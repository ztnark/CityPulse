function trains(map) {
  $.get('/trains', function(response){
    console.log(response[0]);
    var xmlTrains = $.parseXML( response[0] ),
      $xml = $( xmlTrains ),
      $train = $xml.find( "train" );
    console.log($train);
    // var trains = response[0].getElementsByTagName("train");
    // console.log(result);
    // $.each(response, function(index, value){

    //   getMarker(value.latitude, value.longitude, map, value);
    // });
  });
};