var map = undefined;

$(document).ready(function(){
  $(document).on("click", ".city", function(){
    city = this.id
    $('#map-canvas').css("display", "block");
    $('.city').css("display", "none");
    var city_set = new WebSocketRails('localhost:3000/websocket');
      city_set.trigger('events.city', city);
      city_set.bind("events.city_is_set", function(message){
        console.log(message);
        loadMap(message);
    });
  });
});
