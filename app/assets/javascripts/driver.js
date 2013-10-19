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
    $("#feed").prepend("<div id='item'><div id='tweet'>" + message[1] + "</div></div>");
  })

 var instagram = new WebSocketRails('localhost:3000/websocket');

  instagram.trigger("events.instagram")

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






});
