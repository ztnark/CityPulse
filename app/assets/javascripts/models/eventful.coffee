define ['backbone', 'views/marker'], (Backbone, Marker) ->
  class Eventful extends Backbone.Model
    constructor: (eventful) ->
      @coordinates = [eventful.latitude, eventful.longitude]
      @title = eventful.title
      @url = eventful.url
      @icon = "assets/eventful.ico"

    initialize: ->
      

