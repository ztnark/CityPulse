var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;
  // instagram(map)
  // events(map);

  
  var dispatcher = new WebSocketRails('localhost:3000/websocket');

  var test = new WebSocketRails('localhost:3000/websocket');


  dispatcher.trigger("events.instagram")

  dispatcher.bind("events.success", function(message){
     $.each(message, function(index, value){
        setMarker(value.latitude, value.longitude, map);
      console.log(message)
    });
  })

  
  test.trigger("events.tweets")

  test.bind("events.success", function(message){
     convertTweetsToMapObjects(message);
  })



})
