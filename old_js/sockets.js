function initializeWebSockets(map){
  initializeInstagram(map)
  initializeTrains(map)
  initializeBikes(map)
  initializeEventful(map)
  initializeEventbrite(map)
  initializePlanes(map)
  initializeTwitter(map)
}

function initializeTwitter(map) {
   var pusher = new Pusher('86bccb7dee9d1aea8897');
    var channel = pusher.subscribe('twitter_channel');
    channel.bind('twitter_event', function(data) {
  //    convertTweetsToMapObjects(data.message);
    $("#feed").prepend("<div id='item'>" + "<div id='prof'><img src="+ data.message[3]+"></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + data.message[2] +"</div>" + data.message[1] + "<div class='lat'>"+ data.message[0][0] + "</div>" + "<div class='lon'>"+ data.message[0][1] +"</div></div></div>");
  })
}

function initializeInstagram(map){
  var instagram = new WebSocketRails('localhost:3000/websocket');
  instagram.trigger("events.instagram_initialize")
  var colcounter = 1;
  instagram.bind("events.instagram_success", function(message){
    var url = message.url.replace(/(width=)(\d{3})(\sheight=)(\d{3})/,"$1250$3250");
    var $that = $("#instafeed #column" + colcounter).prepend("<div id='instaitem'>" + "<div class='instagram'>" + message.url + "</div><div class='lat'>" + message.latitude + "</div>" + "<div class='lon'>"+ message.longitude +"</div></div>");
    setMarker(message.latitude, message.longitude, map, url);
    console.log(message);
    if (colcounter===3){
      colcounter = 1
    }
    else{
      colcounter +=1
    }
  });
}

function initializeTrains(map){
  var trains = new WebSocketRails('localhost:3000/websocket');
  trains.trigger("events.trains")
  trains.bind("events.success", function(message){
    $.each(message.ctatt.route,function(index, value){
      $.each(value.train,function(ind, val){
        trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.rn.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$)
      });
    })
  })
}

bikeMarkers = []
function initializeBikes(map){
 var bikes = new WebSocketRails('localhost:3000/websocket');
  bikes.trigger("events.bikes");
  bikes.bind("events.success", function(message){
    $.each(message.stationBeanList,function(index, value){
    bikeMarkers.push(bikeMarker(value.latitude, value.longitude, map, value));
    });
  });
}  

function initializePlanes(map){
  var planes = new WebSocketRails('localhost:3000/websocket');
  planes.trigger("events.planes")
  planes.bind("events.success", function(message){
    $.each(message.response.flightTracks.flightTrack,function(index, value){
      var contentString =  "Flight: " + value.flightNumber.$ + " (" + value.equipment.$ + ")<br>" + "Origin: " + value.departureAirportFsCode.$ + "<br>" + "Destination: " + value.arrivalAirportFsCode.$ + "<br>" + "Hdg: " + Math.round(value.heading.$) + "deg<br>" + "Spd: " + value.positions.position[0].speedMph.$ + "mph<br>" + "Alt: " + value.positions.position[0].altitudeFt.$ + "ft"
      planeMarker(value.positions.position[0].lat.$,value.positions.position[0].lon.$, map,contentString)
    });
  });
}

function initializeEventbrite(map){
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
}

function initializeEventful(map){
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
}
