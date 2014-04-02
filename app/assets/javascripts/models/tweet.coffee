define ['backbone'], (Backbone) ->
  class Tweet extends Backbone.Model
    constructor: (tweet_data) ->
      coordinates: tweet_data[0]
      text: tweet_data[1]
      handle: tweet_data[2]
      avatar: tweet_data[3]

