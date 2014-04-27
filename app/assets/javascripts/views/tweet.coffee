define ['backbone', 'views/marker', 'views/map'], (Backbone, Marker, Map) ->
  class TweetView extends Backbone.View
    el: $ '#feed'
    icon: "assets/rsz_1twitter_logo_blue.png"

    events:
      "click #item": "center"

    initialize: (tweet) ->
      @render(tweet)

    render: (tweet) ->
      div = "<div id='item'>" + "<div id='prof'><img src=" + tweet.avatar + "></div><div id='tweet'><div id='screenname'><i class='icon-twitter'></i> @" + tweet.handle + "</div>" + tweet.text + "<div class='lat'>"+ tweet.coordinates[0] + "</div>" + "<div class='lon'>" + tweet.coordinates[1] + "</div></div></div>"
      $(@el).prepend(div)
      new Marker(tweet, @icon)

    center: (event) ->
      event.preventDefault()
      lat = $(event.currentTarget).find('.lat')[0].innerText
      long = $(event.currentTarget).find('.lon')[0].innerText
      Map.get().setCenter(new google.maps.LatLng(lat,long))
      Map.get().setZoom(15)
