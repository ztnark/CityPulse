define ['backbone'], (Backbone) ->
  class Instagram extends Backbone.Model
    constructor: (instagram) ->
      @url = instagram.url
      @coordinates = [instagram.latitude, instagram.longitude]
      @timeout = 240000
      @text = instagram.url
      @div_id = @parse_id(instagram.url)

    initialize: ->

    parse_id: (url) ->
      /.{20}(?=.jpg)/.exec(url)
