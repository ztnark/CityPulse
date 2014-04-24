define ['backbone'], (Backbone) ->
  class Map extends Backbone.View

    instance = null

    @get: ->

      instance ?= @instance()

    @instance = ->
      myOptions =
        center: new google.maps.LatLng 41.892915, -87.635912
        zoom: 12
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new google.maps.Map $('#map-canvas')[0], myOptions
      transitLayer = new google.maps.TransitLayer()
      transitLayer.setMap(map)
      opt = { minZoom: 12, maxZoom: 16 }
      map.setOptions(opt)
      return map
