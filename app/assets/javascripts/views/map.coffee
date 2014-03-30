define ['backbone', 'models/map'], (Backbone, MapModel) ->

  #if you are going to hide the map in the dom, this should be passed the element (#map-canvas) otherwise assign it as the el 
  #override :render and it is a good practice to have it 'return this' at end of function
  class MapView extends Backbone.View
    myOptions:
      center: new google.maps.LatLng 41.892915, -87.635912
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP
    model: MapModel
    tagName: '#map-canvas'
    events:
      'click .city' : "show_map",

    initialize: ->
      console.log 'in initialize'
      console.log @.model
      @model.view = @
      @.render()

    render: ->
      console.log 'in render'
      i = new google.maps.Map $(@.tagName)[0], @.myOptions

