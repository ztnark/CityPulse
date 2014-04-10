define ['backbone'], (Backbone) ->
  class TweetView extends Backbone.View

    el: $ '#feed'

    initialize: (tweet) ->
      @render(tweet)

    render: (tweet) ->
      div = "<div id='item'>" + "<div id='prof'><img src=" + tweet.avatar + "></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + tweet.handle + "</div>" + tweet.text + "<div class='lat'>"+ tweet.coordinates[0] + "</div>" + "<div class='lon'>" + tweet.coordinates[1] + "</div></div></div>"
      $(@el).prepend(div)



