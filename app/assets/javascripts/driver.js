var map = undefined;
$(document).ready(function(){
  map = loadMap();
  var marker;
  // instagram(map)
  // trains(map);
  // events(map);



  var tweets = new WebSocketRails('localhost:3000/websocket');
  tweets.trigger("events.tweets")


  tweets.bind("events.tweet_success", function(message){
     convertTweetsToMapObjects(message);
  })


 var instagram = new WebSocketRails('localhost:3000/websocket');


 instagram.bind("events.instagram_success", function(message){
    console.log(message);
    var message = JSON.parse(message);
    setMarker(message.latitude, message.longitude, map, message.url);
 });


// instagram.trigger("events.instagram")

  var off = 0
  for (var i=0; i<5; i++){
  setTimeout(function(){
    instagram.trigger("events.instagram_initialize")
     instagram.trigger("events.instagram")
  },0+ off);
  off += 30000;
}

 



  var trains = new WebSocketRails('localhost:3000/websocket');

  // trains.trigger("events.trains")

  setInterval(function(){
    trains.trigger("events.trains")
  },15000);


  trains.bind("events.train_success", function(message){
    console.log(message);
        $.each(message.ctatt.route,function(index, value){
          $.each(value.train,function(ind, val){
            trainMarker(val.lat.$, val.lon.$, map, index, 'Train: ' + val.heading.$ + '<br>' + 'Headed to ' + val.destNm.$ + '<br>' + 'Next Stop: ' + val.nextStaNm.$);
          })
        })
  })






});
