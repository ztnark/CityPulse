var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;
  // instagram(map)
  trains(map);
  // events(map);





 //  var test = new WebSocketRails('localhost:3000/websocket');
 //  test.trigger("events.tweets")

 //  test.bind("events.success", function(message){
 //     convertTweetsToMapObjects(message);
 //  })

 // var dispatcher = new WebSocketRails('localhost:3000/websocket');

 //  dispatcher.trigger("events.instagram")

 //  dispatcher.bind("events.success", function(message){
 //        setMarker(message.latitude, message.longitude, map);
 //        console.log(message)
 //  })






});
