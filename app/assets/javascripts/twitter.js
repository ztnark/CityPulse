var styles = undefined
function loadMap(message) {
  var mapOptions = {
    center: new google.maps.LatLng(message['lat'], message['long']),
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

  initializeWebSockets(map)
    
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
  removeTwitterMarker(marker);
}

function removeTwitterMarker(marker){
  setTimeout(function(){marker.setMap(null)},360000);
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
  var marker;

////////TWEETS/////////////////////////////////////

   var pusher = new Pusher('86bccb7dee9d1aea8897');
    var channel = pusher.subscribe('twitter_channel');
    channel.bind('twitter_event', function(data) {
  //    convertTweetsToMapObjects(data.message);
    $("#feed").prepend("<div id='item'>" + "<div id='prof'><img src="+ data.message[3]+"></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + data.message[2] +"</div>" + data.message[1] + "<div class='lat'>"+ data.message[0][0] + "</div>" + "<div class='lon'>"+ data.message[0][1] +"</div></div></div>");
  })

// ////////EVENTFUL/////////////////////////////////////

  
  function stadiumThrob(stadium){
    setInterval(function(){
        stadium.setMap(null)
      if(stadium.fillOpacity === 0.2){
        stadium.fillOpacity = 0.3
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.3){
        stadium.fillOpacity = 0.4
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.4){
        stadium.fillOpacity = 0.5
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.5){
        stadium.fillOpacity = 0.6
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.6){
        stadium.fillOpacity = 0.7
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.7){
        stadium.fillOpacity = 0.8
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.8){
        stadium.fillOpacity = 0.9
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.9){
        stadium.fillOpacity = 0.81
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.81){
        stadium.fillOpacity = 0.71
        stadium.setMap(map);
      }
      else if(stadium.fillOpacity === 0.71){
        stadium.fillOpacity = 0.61
        stadium.setMap(map);
      }  else if(stadium.fillOpacity === 0.61){
        stadium.fillOpacity = 0.51
        stadium.setMap(map);
      }  else if(stadium.fillOpacity === 0.51){
        stadium.fillOpacity = 0.41
        stadium.setMap(map);
      }  else if(stadium.fillOpacity === 0.41){
        stadium.fillOpacity = 0.31
        stadium.setMap(map);
      }  else if(stadium.fillOpacity === 0.31){
        stadium.fillOpacity = 0.2
        stadium.setMap(map);
      }
    },100);
  }

////////  EVENTBRITE   /////////////////////////////////////

// // ////////PLANES/////////////////////////////////////

google.maps.event.addListener(map, 'zoom_changed', function () {

   var currentZoom = map.getZoom();

   if (currentZoom > 14) {
      for(var i = 0; i <= bikeMarkers.length-1; i++){
      bikeMarkers[i].setMap(map);
      }
   }
   else
     for(var i = 0; i <= bikeMarkers.length-1; i++){
       (bikeMarkers[i]).setMap(null);
     };
});
  $(document).on("click","#item",function(){
    var at = $(this.children[0].nextSibling.children[1].innerText)
    var on = $(this.children[0].nextSibling.children[2].innerText)
    var lat = (at['selector'])
    var lon = (on['selector'])
    map.setCenter(new google.maps.LatLng(lat,lon));
    map.setZoom(15)
  });

  $(document).on("click","#instaitem",function(e){
    e.preventDefault();
    console.log(this)
    var instaAt = $(this.children[0].nextSibling.innerText)
    var instaOn = $(this.children[1].nextSibling.innerText)
    var instaLat = (instaAt['selector'])
    var instaLon = (instaOn['selector'])
    map.setCenter(new google.maps.LatLng(instaLat,instaLon));
    map.setZoom(15)
  });
}
