define ['jquery', 'backbone', 'models/tweet', 'views/tweet', 'models/instagram', 'views/instagram', 'views/train', 'models/train', 'models/eventful', 'views/eventful'], ($, Backbone, Tweet, TweetView, Instagram, InstagramView, TrainView, Train, Eventful, EventfulView) ->

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

      train_channel = new WebSocketRails('localhost:3000/websocket')
      train_channel.trigger('events.trains')
      train_channel.bind "events.success", (message) ->
        $.each message.ctatt.route, (index, value) ->
          $.each value.train, (ind, val) ->
            tr = new Train(val, ind)
            new TrainView(tr)

      eventful = new WebSocketRails("localhost:3000/websocket")
      eventful.trigger "events.eventful"
      eventful.bind "events.eventful_success", (message) ->
        $.each message, (index, value) ->
          event = new Eventful(value)
          new EventfulView(event)
          
      twitter_channel =  @.pusher.subscribe('twitter_channel')
      twitter_channel.bind 'twitter_event', (data) ->
        t = new Tweet(data['message'])
        new TweetView (t)
