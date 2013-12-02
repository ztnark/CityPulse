var map = undefined;

$(document).ready(function(){
  map = loadMap();
  var marker;
  var x = 0;
  // ////////////////////////////////Playing with polygons/////////////////////
var unitedCenter;
var unitedCoords = [
    new google.maps.LatLng(41.88122,-87.676477),
    new google.maps.LatLng(41.878866,-87.676477),
    new google.maps.LatLng(41.878866,-87.6718),
    new google.maps.LatLng(41.88122,-87.6718)
  ];
    unitedCenter = new google.maps.Polygon({
    paths: unitedCoords,
    strokeColor: 'red',
    strokeOpacity: 0.2,
    strokeWeight: 0,
    fillColor: 'red',
    fillOpacity: 0.2
  });

var dbc;
var dbcCoords = [
    new google.maps.LatLng(41.88988,-87.637929),
    new google.maps.LatLng(41.889609,-87.637923),
    new google.maps.LatLng(41.889613,-87.637119),
    new google.maps.LatLng(41.889892,-87.637119)
  ];
    dbc = new google.maps.Polygon({
    paths: dbcCoords,
    strokeColor: 'red',
    strokeOpacity: 0.2,
    strokeWeight: 0,
    fillColor: 'red',
    fillOpacity: 0.2
  });


var soldierField;
var soldierCoords = [
    new google.maps.LatLng(41.864934,-87.618778),
    new google.maps.LatLng(41.864934,-87.614207),
    new google.maps.LatLng(41.860427,-87.614121),
    new google.maps.LatLng(41.860379,-87.617404)
  ];
    soldierField = new google.maps.Polygon({
    paths: soldierCoords,
    strokeColor: 'red',
    strokeOpacity: 0.2,
    strokeWeight: 0,
    fillColor: 'red',
    fillOpacity: 0.2
  });


var wrigleyField;
var wrigleyCoords = [
    new google.maps.LatLng(41.948997,-87.654462),
    new google.maps.LatLng(41.944532,-87.654338),
    new google.maps.LatLng(41.948949,-87.657788)
  ];
    wrigleyField = new google.maps.Polygon({
    paths: wrigleyCoords,
    strokeColor: 'red',
    strokeOpacity: 0.2,
    strokeWeight: 0,
    fillColor: 'red',
    fillOpacity: 0.2
  });


var comiskeyField;
var comiskeyCoords = [
    new google.maps.LatLng(41.83076,-87.63869),
    new google.maps.LatLng(41.827258,-87.638648),
    new google.maps.LatLng(41.827326,-87.631481),
    new google.maps.LatLng(41.830855,-87.631631)
  ];

    comiskeyField = new google.maps.Polygon({
    paths: comiskeyCoords,
    strokeColor: 'red',
    strokeOpacity: 0.2,
    strokeWeight: 0,
    fillColor: 'red',
    fillOpacity: 0.2
  });

////////TWEETS/////////////////////////////////////

   var pusher = new Pusher('86bccb7dee9d1aea8897');
    var channel = pusher.subscribe('twitter_channel');
    channel.bind('twitter_event', function(data) {
      convertTweetsToMapObjects(data.message);
    $("#feed").prepend("<div id='item'>" + "<div id='prof'><img src="+ data.message[3]+"></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + data.message[2] +"</div>" + data.message[1] + "<div class='lat'>"+ data.message[0][0] + "</div>" + "<div class='lon'>"+ data.message[0][1] +"</div></div></div>");
  })


// ////////EVENTFUL/////////////////////////////////////

 var eventful = new WebSocketRails('limitless-temple-4888.herokuapp.com/websocket');
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
  var eventbrite = new WebSocketRails('limitless-temple-4888.herokuapp.com/websocket');
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
  var instagram = new WebSocketRails('limitless-temple-4888.herokuapp.com/websocket');
  instagram.trigger("events.instagram_initialize")
  var colcounter = 1;
  // var idcounter = 1;
  instagram.bind("events.instagram_success", function(message){
    var url = message.url.replace(/(width=)(\d{3})(\sheight=)(\d{3})/,"$1250$3250");
    var $that = $("#instafeed #column" + colcounter).prepend("<div id='instaitem'>" + "<div class='instagram'>" + message.url + "</div><div class='lat'>" + message.latitude + "</div>" + "<div class='lon'>"+ message.longitude +"</div></div>");
    setMarker(message.latitude, message.longitude, map, url);
    // setTimeout(function(){
      // var id_remove = '#' + (idcounter - 1)
       // $(id_remove).remove()
     // },10000);
    // setTimeout(function(){
    //   $that.remove();
    //   console.log("test")
    // },120000)
    if (colcounter===3){
      colcounter = 1
    }
    else{
      colcounter +=1
    }

    // if (idcounter === 25){
    //   idcounter = 1
    // }
    // else {
    //   idcounter += 1
    // }
  });

// ////////TRAINS/////////////////////////////////////
  var trains = new WebSocketRails('limitless-temple-4888.herokuapp.com/websocket');
  trains.trigger("events.trains")
  trains.bind("events.success", function(message){
    // console.log(message);
    $.each(message.ctatt.route,function(index, value){
      $.each(value.train,function(ind, val){
        trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.rn.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$)
        // + ' in ' + Math.round(((new Date(val.arrT.$.replace(/(\d{4})(\d{2})(\d{2})/,"$1-$2-$3")) - new Date()) / 60000 )) + ' minutes' )
      });
    })
  })

// // ////////PLANES/////////////////////////////////////
  var planes = new WebSocketRails('limitless-temple-4888.herokuapp.com/websocket');
  planes.trigger("events.planes")
  planes.bind("events.success", function(message){
    $.each(message.response.flightTracks.flightTrack,function(index, value){
      var contentString =  "Flight: " + value.flightNumber.$ + " (" + value.equipment.$ + ")<br>" + "Origin: " + value.departureAirportFsCode.$ + "<br>" + "Destination: " + value.arrivalAirportFsCode.$ + "<br>" + "Hdg: " + Math.round(value.heading.$) + "deg<br>" + "Spd: " + value.positions.position[0].speedMph.$ + "mph<br>" + "Alt: " + value.positions.position[0].altitudeFt.$ + "ft"
      planeMarker(value.positions.position[0].lat.$,value.positions.position[0].lon.$, map,contentString)
    })
  })
bikeMarkers = []
// // ////////BIKES/////////////////////////////////////

 var bikes = new WebSocketRails('limitless-temple-4888.herokuapp.com/websocket');

  bikes.trigger("events.bikes");
  bikes.bind("events.success", function(message){
    $.each(message.stationBeanList,function(index, value){
      // console.log(value)
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

////////////// CENTER ON TWEET & INSTA WHEN CLICKED IN SIDEBAR //////
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
////////////////////////////////////////////////////////////////////

  $('.timemode').on("click",function(){
    console.log("clicked");
    if (x === 0){
      var styles = [
  {
    "stylers": [
      { "invert_lightness": true },
      { "lightness": 23 }
    ]
  },{
    "featureType": "road",
    "stylers": [
      { "visibility": "off" }
    ]
  },{
    "stylers": [
      { "lightness": 19 }
    ]
  }]
  x = 1
    }
    else{
      var styles = [
      {
    "stylers": [
      { "invert_lightness": true }
    ]
  },{
    "featureType": "road",
    "stylers": [
      { "visibility": "off" }
    ]
  },{
    "stylers": [
      { "lightness": 19 }
    ]
  }];
  x = 0;
}
  console.log(x)

// map.setOptions({styles: styles});
});

});
