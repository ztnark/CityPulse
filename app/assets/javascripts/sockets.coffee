define ['jquery', 'backbone', 'models/tweet', 'views/tweet', 'models/instagram', 'views/instagram'], ($, Backbone, Tweet, TweetView, Instagram, InstagramView) ->

  class Sockets extends Backbone.Model
    pusher: new Pusher('86bccb7dee9d1aea8897')

    initialize: ->
      instagram_channel = new WebSocketRails('localhost:3000/websocket')
      instagram_channel.trigger('events.instagram_initialize')
      colcounter = 1
      instagram_channel.bind "events.instagram_success", (message) ->
        i = new Instagram(message)
        if colcounter is 3
          colcounter = 1
        else
          colcounter += 1
        new InstagramView(i, colcounter)

      
      twitter_channel =  @.pusher.subscribe('twitter_channel')
      twitter_channel.bind 'twitter_event', (data) ->
        t = new Tweet(data['message'])
        new TweetView (t)
