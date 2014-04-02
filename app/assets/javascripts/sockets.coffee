define ['jquery', 'backbone', 'models/tweet'], ($, Backbone, Tweet) ->

  class Sockets extends Backbone.Model
    pusher: new Pusher('86bccb7dee9d1aea8897')
    feed: "#feed"

    initialize: ->
      channel =  @.pusher.subscribe('twitter_channel')
      channel.bind 'twitter_event', (data) ->
        new Tweet(data['message'])
        $("#feed").prepend "<div id='item'>" + "<div id='prof'><img src=" + data.message[3]+ "></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + data.message[2] + "</div>" + data.message[1] + "<div class='lat'>" + data.message[0][0] + "</div>" + "<div class='lon'>" + data.message[0][1] + "</div></div></div>"

