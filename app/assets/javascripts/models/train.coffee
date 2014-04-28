define ['backbone', 'views/marker'], (Backbone, Marker) ->
  class Train extends Backbone.Model
    constructor: (train_data, line) ->
      @coordinates = [train_data.lat.$ || 0, train_data.lon.$ || 0]
      @name = train_data.rn.$ || 'data not reported'
      @destination = train_data.destNm.$ || 'or data not reported'
      @next_stop = train_data.nextStaNm.$ || 'or data not reported'
      @line = line
      @icon = "assets/train#{line}.png"

    initialize: ->
      
