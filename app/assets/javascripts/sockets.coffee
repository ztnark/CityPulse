define ['jquery', 'backbone', 'models/tweet', 'views/tweet'], ($, Backbone, Tweet, TweetView) ->

  class Sockets extends Backbone.Model
    pusher: new Pusher('86bccb7dee9d1aea8897')
    feed: "#feed"

    initialize: ->
      channel =  @.pusher.subscribe('twitter_channel')
      channel.bind 'twitter_event', (data) ->
        t = new Tweet(data['message'])
        new TweetView (t)
