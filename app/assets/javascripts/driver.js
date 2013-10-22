var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;


  var x = 0;

////////EVENTFUL/////////////////////////////////////


  var eventful = new WebSocketRails('localhost:3000/websocket');

  eventful.trigger("events.eventful")

  setInterval(function(){
    eventful.trigger("events.eventful")
  },180000);

  eventful.bind("events.eventful_success", function(message){
    console.log(message);
    $.each(message, function(index, value){
      getMarker(value.latitude, value.longitude, map, value);
    });
  })


////////TWEETS/////////////////////////////////////


  var tweets = new WebSocketRails('localhost:3000/websocket');
  // tweets.trigger("events.tweets")

  // tweets.bind("events.tweet_success", function(message){
  //   convertTweetsToMapObjects(message);
  //   $("#feed").prepend("<div id='item'>" + "<div id='prof'><img src="+message[3]+"></div><div id='tweet'>@" +message[2] +"<br>" + message[1] + "</div></div>");
  // })

////////INSTAGRAMS/////////////////////////////////////


  var instagram = new WebSocketRails('localhost:3000/websocket');

  instagram.trigger("events.instagram_initialize")

  instagram.bind("events.instagram_success", function(message){
    console.log(message);
    $("#feed").prepend("<div id='item'><div id='instagram'>" + message.url + "</div></div>");
    setMarker(message.latitude, message.longitude, map, message.url);
  });

////////TRAINS/////////////////////////////////////




  var trains = new WebSocketRails('localhost:3000/websocket');

  trains.trigger("events.trains")


  trains.bind("events.success", function(message){
    console.log(message);
    $.each(message.ctatt.route,function(index, value){
      $.each(value.train,function(ind, val){
        trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.rn.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$);
      })
    })
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
