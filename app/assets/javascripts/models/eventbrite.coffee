define ['backbone', 'views/marker'], (Backbone, Marker) ->
  class Eventbrite extends Backbone.Model
    constructor: (eventbrite) ->
      @coordinates = [eventbrite.latitude, eventbrite.longitude]
      @title = eventbrite.title
      @url = eventbrite.url
      @venue = eventbrite.venue
      @start_time = eventbrite.at_time
      @icon = "assets/eventbrite.png"

    initialize: ->
      


