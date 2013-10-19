var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;
  // instagram(map)
  // trains(map);
  // events(map);





  var tweets = new WebSocketRails('localhost:3000/websocket');
  tweets.trigger("events.tweets")

  tweets.bind("events.success", function(message){
     convertTweetsToMapObjects(message);
  })

 var instagram = new WebSocketRails('localhost:3000/websocket');

  instagram.trigger("events.instagram")

  instagram.bind("events.success", function(message){
        setMarker(message.latitude, message.longitude, map);
        console.log(message)
  })



  var trains = new WebSocketRails('localhost:3000/websocket');

  trains.trigger("events.trains")

  trains.bind("events.success", function(message){
    console.log(message);
        $.each(message.ctatt.route,function(index, value){
          $.each(value.train,function(index, val){
            trainMarker(val.lat.$, val.lon.$, map);
          })
        })
  })






});
