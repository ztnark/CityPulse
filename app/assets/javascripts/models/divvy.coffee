define ['backbone', 'views/marker'], (Backbone, Marker) ->
  class Divvy extends Backbone.Model
    constructor: (divvy) ->
      @coordinates = [divvy.latitude, divvy.longitude]
      @station_name = divvy.stationName
      @available_bikes = divvy.availableBikes
      @available_docks = divvy.availableDocks
      @url = divvy.url
      @icon = "assets/divvy.png"

    initialize: ->

