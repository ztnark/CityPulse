var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;
  getTweets();
  instagram(map)
  events(map);
  
  var dispatcher = new WebSocketRails('localhost:3000/websocket');


  dispatcher.on_open = function(asd){
    console.log(asd);
  }

  
  dispatcher.trigger("events.tweets")

  dispatcher.bind("events.success", function(message){
    console.log(message);
  })
})
