// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// function convertTweetsToMapObjects(response){
//   for (var i=0; i<response.length; i++){
//     rawtweets[i] = new google.maps.LatLng(response[i][0], response[i][1]);
//   });
// });


function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(41.8929153,-87.6359125),
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);
  tweets = []
  $.post('/tweets_supply', function(response){
    console.log(response);
  
  // convertTweetsToMapObjects(response);
  });

};




google.maps.event.addDomListener(window, 'load', initialize);



