var styles = undefined
function loadMap() {
  var mapOptions = {
    center: new google.maps.LatLng(41.8929153,-87.6359125),
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    disableDefaultUI: true,
    styles: styles
  };

  var map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);

  var marker = new google.maps.Marker({
  });

  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  var opt = { minZoom: 12, maxZoom: 16 };
    map.setOptions(opt);

  // map.setOptions({styles: styles});
    return map;
};

var mapObjectArray = [];
function convertTweetsToMapObjects(tweet_from_socket){
  tweet = [new google.maps.LatLng(tweet_from_socket[0][0],tweet_from_socket[0][1]),tweet_from_socket[1],tweet_from_socket[2]]
  convertToMarkers(tweet);
};

function convertToMarkers(tweet){
  var marker = new google.maps.Marker({
    animation: google.maps.Animation.BOUNCE,
    position: tweet[0],
    map: map,
    icon: 'http://main.diabetes.org/dorg/images/hp/twitter_icon.gif',
    title: 'tweet'
  });
  addInfoWindow(marker, tweet[1])
  setTimeout(function(){ marker.setAnimation(null); }, 750);
  removeMarker(marker);
}

function removeMarker(marker){
  setTimeout(function(){marker.setMap(null)},10000000);
}


function addInfoWindow(marker, message) {
            var info = message;

            var infoWindow = new google.maps.InfoWindow({
                content: message,
                maxWidth: 200
            });

            google.maps.event.addListener(marker,'mouseover', function(e){
              infoWindow.open(map,marker);
            });
            google.maps.event.addListener(marker,'mouseout', function(e){
              // console.log(e);
              // $('.gm-style-iw').close();
              infoWindow.close();
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



