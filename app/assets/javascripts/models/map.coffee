define ['backbone'], (Backbone) ->
  class Map extends Backbone.Model
    myOptions:
      center: new google.maps.LatLng -34.39789, 50.44789
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP

    initialize: ->

