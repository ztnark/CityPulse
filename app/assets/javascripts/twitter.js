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

 var eventful = new WebSocketRails('localhost:3000/websocket');
  eventful.trigger("events.eventful")
  setInterval(function(){
    eventful.trigger("events.eventful")
  },180000);
  eventful.bind("events.eventful_success", function(message){
    $.each(message, function(index, value){
      if(value.venue_name =="United Center"){
        stadiumThrob(unitedCenter);
        getMarker(value.latitude, value.longitude, map, value);
      }
      else if(value.venue_name =="Soldier Field Stadium"){
        getMarker(value.latitude, value.longitude, map, value);
        stadiumThrob(soldierField);
      }
      else if(value.venue_name =="Wrigley Field"){
        getMarker(value.latitude, value.longitude, map, value);
        stadiumThrob(wrigleyField);
      }
      else if(value.venue_name =="U.S. Cellular Field"){
        getMarker(value.latitude, value.longitude, map, value);
        stadiumThrob(comiskeyField);
      }
      else if(value.venue_name =="Dev Bootcamp Chicago"){
        getMarker(value.latitude, value.longitude, map, value);
        stadiumThrob(dbc);
      }
      else{
        getMarker(value.latitude, value.longitude, map, value);
      }
    });
  });
  
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
  var eventbrite = new WebSocketRails('localhost:3000/websocket');
  eventbrite.trigger("events.eventbrite")
  setInterval(function(){
    eventbrite.trigger("events.eventbrite")
  },180000);
  eventbrite.bind("events.eventbrite_success", function(message){
    $.each(message, function(index, value){
      briteMarker(value.latitude, value.longitude, map, value);
    });
  });

////////INSTAGRAMS/////////////////////////////////////
  var instagram = new WebSocketRails('localhost:3000/websocket');
  instagram.trigger("events.instagram_initialize")
  var colcounter = 1;
  instagram.bind("events.instagram_success", function(message){
    var url = message.url.replace(/(width=)(\d{3})(\sheight=)(\d{3})/,"$1250$3250");
    var $that = $("#instafeed #column" + colcounter).prepend("<div id='instaitem'>" + "<div class='instagram'>" + message.url + "</div><div class='lat'>" + message.latitude + "</div>" + "<div class='lon'>"+ message.longitude +"</div></div>");
    setMarker(message.latitude, message.longitude, map, url);
    if (colcounter===3){
      colcounter = 1
    }
    else{
      colcounter +=1
    }

  });

// ////////TRAINS/////////////////////////////////////
  var trains = new WebSocketRails('localhost:3000/websocket');
  trains.trigger("events.trains")
  trains.bind("events.success", function(message){
    $.each(message.ctatt.route,function(index, value){
      $.each(value.train,function(ind, val){
        trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.rn.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$)
      });
    })
  })

// // ////////PLANES/////////////////////////////////////
  var planes = new WebSocketRails('localhost:3000/websocket');
  planes.trigger("events.planes")
  planes.bind("events.success", function(message){
    $.each(message.response.flightTracks.flightTrack,function(index, value){
      var contentString =  "Flight: " + value.flightNumber.$ + " (" + value.equipment.$ + ")<br>" + "Origin: " + value.departureAirportFsCode.$ + "<br>" + "Destination: " + value.arrivalAirportFsCode.$ + "<br>" + "Hdg: " + Math.round(value.heading.$) + "deg<br>" + "Spd: " + value.positions.position[0].speedMph.$ + "mph<br>" + "Alt: " + value.positions.position[0].altitudeFt.$ + "ft"
      planeMarker(value.positions.position[0].lat.$,value.positions.position[0].lon.$, map,contentString)
    })
  })
bikeMarkers = []
// // ////////BIKES/////////////////////////////////////

 var bikes = new WebSocketRails('localhost:3000/websocket');

  bikes.trigger("events.bikes");
  bikes.bind("events.success", function(message){
    $.each(message.stationBeanList,function(index, value){
    bikeMarkers.push(bikeMarker(value.latitude, value.longitude, map, value));
    });
  });

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
