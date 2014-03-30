define ['jquery', 'backbone'], ($, Backbone) ->

  class Sockets extends Backbone.Model
    pusher: new Pusher('86bccb7dee9d1aea8897')
    feed: "#feed"

    initialize: ->
      console.log @.feed
      channel =  @.pusher.subscribe('twitter_channel')
      channel.bind 'twitter_event', (data) ->
        $("#feed").prepend "<div id='item'>" + "<div id='prof'><img src=" + data.message[3]+ "></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + data.message[2] + "</div>" + data.message[1] + "<div class='lat'>" + data.message[0][0] + "</div>" + "<div class='lon'>" + data.message[0][1] + "</div></div></div>"
