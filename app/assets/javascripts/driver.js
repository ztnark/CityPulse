var map = undefined;

$(document).ready(function(){
  map = loadMap();
  var marker;

  var x = 0;

// ////////EVENTFUL/////////////////////////////////////

  var eventful = new WebSocketRails('localhost:3000/websocket');

  eventful.trigger("events.eventful")

  setInterval(function(){
    eventful.trigger("events.eventful")
  },180000);

  // var eventful = new WebSocketRails('localhost:3000/websocket');

  // eventful.trigger("events.eventful")

  // setInterval(function(){
  //   eventful.trigger("events.eventful")
  // },180000);

  // eventful.bind("events.eventful_success", function(message){
  //   console.log(message);
  //   $.each(message, function(index, value){
  //     getMarker(value.latitude, value.longitude, map, value);
  //   });
  // })

  eventful.bind("events.eventful_success", function(message){
    // console.log(message);
    $.each(message, function(index, value){
      getMarker(value.latitude, value.longitude, map, value);
    });
  })

////////TWEETS/////////////////////////////////////
  
  // var tweets = new WebSocketRails('localhost:3000/websocket');
  // tweets.trigger("events.tweets")

  // tweets.bind("events.tweet_success", function(message){
  //   convertTweetsToMapObjects(message);
  //   $("#feed").prepend("<div id='item'>" + "<div id='prof'><img src="+message[3]+"></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" +message[2] +"</div>" + message[1] + "<div class='lat'>"+ message[0][0] + "</div>" + "<div class='lon'>"+ message[0][1] +"</div></div></div>");
  // })

////////INSTAGRAMS/////////////////////////////////////

  var instagram = new WebSocketRails('localhost:3000/websocket');

  instagram.trigger("events.instagram_initialize")

  
  var colcounter = 1;

  instagram.bind("events.instagram_success", function(message){

    console.log(colcounter);

    var $that = $("#instafeed #column" + colcounter).prepend("<div id='instaitem'>" + "<div id='instagram'>" + message.url + "</div><div class='lat'>" + message.latitude + "</div>" + "<div class='lon'>"+ message.longitude +"</div></div>");
    setMarker(message.latitude, message.longitude, map, message.url);
    setTimeout(function(){
      $that.remove();
      console.log("test")
    },120000)
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
    // console.log(message);
    $.each(message.ctatt.route,function(index, value){
      $.each(value.train,function(ind, val){
        trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.rn.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$)
        // + ' in ' + Math.round(((new Date(val.arrT.$.replace(/(\d{4})(\d{2})(\d{2})/,"$1-$2-$3")) - new Date()) / 60000 )) + ' minutes' )
      })
    })
  })


// // ////////PLANES/////////////////////////////////////

  var planes = new WebSocketRails('localhost:3000/websocket');
//   var planes = new WebSocketRails('localhost:3000/websocket');

  planes.bind("events.success", function(message){
    // console.log(message);
    $.each(message.response.flightTracks.flightTrack,function(index, value){
      console.log(value);
      var contentString =  "Flight: " + value.flightNumber.$ + " (" + value.equipment.$ + ")<br>" + "Origin: " + value.departureAirportFsCode.$ + "<br>" + "Destination: " + value.arrivalAirportFsCode.$ + "<br>" + "Hdg: " + Math.round(value.heading.$) + "deg<br>" + "Spd: " + value.positions.position[0].speedMph.$ + "mph<br>" + "Alt: " + value.positions.position[0].altitudeFt.$ + "ft"
      planeMarker(value.positions.position[0].lat.$,value.positions.position[0].lon.$, map,contentString)
    })
  })

//   planes.trigger("events.planes")

//   planes.bind("events.success", function(message){
//     console.log(message);
//     $.each(message.response.flightTracks.flightTrack,function(index, value){
//         planeMarker(value.positions.position[0].lat.$,value.positions.position[0].lon.$, map, "This is a plane.");
//     })
//   })

// // ////////BIKES/////////////////////////////////////

 var bikes = new WebSocketRails('localhost:3000/websocket');

  bikes.trigger("events.bikes");

  bikes.bind("events.success", function(message){
    $.each(message.stationBeanList,function(index, value){
      // console.log(value)
      bikeMarker(value.latitude, value.longitude, map, value);
    });
  });


  $(document).on("click","#item",function(){
    var at = $(this.children[0].nextSibling.children[1].innerText)
    var on = $(this.children[0].nextSibling.children[2].innerText)
    var lat = (at['selector'])
    var lon = (on['selector'])
    map.setCenter(new google.maps.LatLng(lat,lon));
    map.setZoom(15)
  })

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
