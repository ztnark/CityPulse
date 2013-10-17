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
//   
// });


function initialize() {

  var mapOptions = {
    center: new google.maps.LatLng(41.8929153,-87.6359125),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
   var map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);

  var mapObjectArray = [];
  function convertTweetsToMapObjects(array_of_tweets){
    for (var i=0; i<array_of_tweets.length; i++){
      mapObjectArray.push([new google.maps.LatLng(array_of_tweets[i][0][0], array_of_tweets[i][0][1]), array_of_tweets[i][1], array_of_tweets[i][2]]);
    };
    console.log(mapObjectArray);
    convertToMarkers(mapObjectArray);
  };

  function convertToMarkers(googleMapArray){
    for (var i=0; i<googleMapArray.length; i++){
      marker = new google.maps.Marker({
      position: googleMapArray[i][0],
      map: map,
      title: 'tweet'
    });
     addInfoWindow(marker, googleMapArray[i][1])
    //  var infowindow = new google.maps.InfoWindow({
    //   content: googleMapArray[i][1]
    // })
   };
  } 

  function addInfoWindow(marker, message) {
            var info = message;

            var infoWindow = new google.maps.InfoWindow({
                content: message
            });

            google.maps.event.addListener(marker, 'click', function () {
                infoWindow.open(map, marker);
            });
        }

var marker;
 $.post('/tweets_supply', function(response){
  console.log(response);
  
  convertTweetsToMapObjects(response);
});

$(document).ajaxStop(function () {
  console.log("ready")
    google.maps.event.addListener(marker, 'click', function() {
      console.log("Hi :D")
    infowindow.open(map,marker);
  });
});


};




google.maps.event.addDomListener(window, 'load', initialize);




