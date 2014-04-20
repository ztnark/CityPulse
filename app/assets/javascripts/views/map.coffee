define ['backbone'], (Backbone) ->
  class Map extends Backbone.View

    instance = null

    @get: ->
      myOptions =
        center: new google.maps.LatLng 41.892915, -87.635912
        zoom: 12
        mapTypeId: google.maps.MapTypeId.ROADMAP
      instance ?= new google.maps.Map $('#map-canvas')[0], myOptions
