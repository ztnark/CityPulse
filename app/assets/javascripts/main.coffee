$ ->
  #if you are going to hide the map in the dom, this should be passed the element (#map-canvas) otherwise assign it as the el 
  #override :render and it is a good practice to have it 'return this' at end of function


  class Map extends Backbone.Model
    myOptions:
      center: new google.maps.LatLng -34.39789, 50.44789
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP

    initialize: ->
      console.log @.myOptions


  class MapView extends Backbone.View
    myOptions:
      center: new google.maps.LatLng -34.39789, 50.44789
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP

    model: Map
    tagName: '#map-canvas'
    events:
      'click .city' : "show_map",

    initialize: ->
      @model.view = @
      @.render()


    render: ->
      i = new google.maps.Map $(@.tagName)[0], @.myOptions
      i
      console.log @model
      console.log i

    
  mapview = new MapView

