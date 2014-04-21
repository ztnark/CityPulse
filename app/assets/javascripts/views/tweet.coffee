define ['backbone', 'views/marker'], (Backbone, Marker) ->
  class TweetView extends Backbone.View

    el: $ '#feed'
    icon: "assets/rsz_1twitter_logo_blue.png"

    initialize: (tweet) ->
      @render(tweet)

    render: (tweet) ->
      div = "<div id='item'>" + "<div id='prof'><img src=" + tweet.avatar + "></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + tweet.handle + "</div>" + tweet.text + "<div class='lat'>"+ tweet.coordinates[0] + "</div>" + "<div class='lon'>" + tweet.coordinates[1] + "</div></div></div>"
      $(@el).prepend(div)
      new Marker(tweet, @icon)
