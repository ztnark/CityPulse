function loadMap() {

  var mapOptions = {
    center: new google.maps.LatLng(41.8929153,-87.6359125),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP

    

  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);
  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);
  return map;
};



var mapObjectArray = [];
function convertTweetsToMapObjects(tweet_from_socket){

      tweet = [new google.maps.LatLng(tweet_from_socket[0][0],tweet_from_socket[0][1]),tweet_from_socket[1],tweet_from_socket[2]]
      convertToMarkers(tweet);
};


function convertToMarkers(tweet){
      marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      position: tweet[0],
      map: map,
      icon: 'http://main.diabetes.org/dorg/images/hp/twitter_icon.gif',
      title: 'tweet'
    });
     addInfoWindow(marker, tweet[1])
     removeMarker(marker);
}

function removeMarker(marker){
  setTimeout(function(){marker.setMap(null)},30000);

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



