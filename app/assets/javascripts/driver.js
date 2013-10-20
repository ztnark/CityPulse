var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;


  var x = 0;

  var eventful = new WebSocketRails('localhost:3000/websocket');

  eventful.trigger("events.eventful")

  setInterval(function(){
    trains.trigger("events.eventful")
  },900000);

  eventful.bind("events.success", function(message){
    console.log(message);
    $.each(message, function(index, value){
      getMarker(value.latitude, value.longitude, map, value);
    });
  })

  var tweets = new WebSocketRails('localhost:3000/websocket');
  tweets.trigger("events.tweets")


  tweets.bind("events.tweet_success", function(message){
     convertTweetsToMapObjects(message);
    $("#feed").prepend("<div id='item'>" + "<div id='prof'><img src="+message[3]+"></div><div id='tweet'>@" +message[2] +"<br>" + message[1] + "</div></div>");
  })


 var instagram = new WebSocketRails('localhost:3000/websocket');

 instagram.trigger("events.instagram")

 instagram.bind("events.instagram_success", function(message){
    console.log(message);
    var message = JSON.parse(message);
    setMarker(message.latitude, message.longitude, map, message.url);
 });


  var off = 0
  for (var i=0; i<5; i++){
  setTimeout(function(){
     instagram.trigger("events.instagram")
     console.log("new")
  },0+ off);
  off += 30000;

}


  instagram.bind("events.success", function(message){
        setMarker(message.latitude, message.longitude, map, message.url);
        $("#feed").prepend("<div id='item'><div id='instagram'>" + message.url + "</div></div>");
        console.log(message)
  })



  var trains = new WebSocketRails('localhost:3000/websocket');

  trains.trigger("events.trains")

  setInterval(function(){
    trains.trigger("events.trains")
  },15000);


  trains.bind("events.success", function(message){
    console.log(message);
        $.each(message.ctatt.route,function(index, value){
          $.each(value.train,function(ind, val){
            trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.heading.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$);
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
