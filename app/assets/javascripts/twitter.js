function loadMap() {

  var mapOptions = {
    center: new google.maps.LatLng(41.8929153,-87.6359125),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
   var map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);
   return map;
};



var mapObjectArray = [];
function convertTweetsToMapObjects(tweet_from_socket){

      tweet = [new google.maps.LatLng(tweet_from_socket[0][0],tweet_from_socket[0][1]),tweet_from_socket[1],tweet_from_socket[2]]
      mapObjectArray.push(tweet);
      console.log(mapObjectArray);
      convertToMarkers(mapObjectArray);
};

function convertToMarkers(googleMapArray){
    for (var i=0; i<googleMapArray.length; i++){
      marker = new google.maps.Marker({
      position: googleMapArray[i][0],
      map: map,
      title: 'tweet'
    });
     addInfoWindow(marker, googleMapArray[i][1])
   };
} 

function addInfoWindow(marker, message) {
            var info = message;

            var infoWindow = new google.maps.InfoWindow({
                content: message
            });

            google.maps.event.addListener(marker, 'click', function () {
                infoWindow.open(map, marker);
            });
}

// function getTweets() {
//   $.post('/tweets_supply', function(response){
//   console.log(response);
 
// });



// $(document).ajaxStop(function () {
//     google.maps.event.addListener(marker, 'click', function() {
//     infowindow.open(map,marker);
//   });

// });
// }





// google.maps.event.addDomListener(window, 'load', initialize);



