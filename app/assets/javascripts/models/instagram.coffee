define ['backbone'], (Backbone) ->
  class Instagram extends Backbone.Model
    constructor: (instagram) ->
      @url = instagram.url
      @coordinates = [instagram.latitude, instagram.longitude]


    initialize: ->



