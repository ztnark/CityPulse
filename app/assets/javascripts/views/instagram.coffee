define ['backbone', 'views/marker'], (Backbone, Marker) ->
  class InstagramView extends Backbone.View

    el: $("#instafeed")
    icon: "assets/rsz_1instagram_icon_large.png"

    initialize: (gram, colcounter) ->
      @render(gram, colcounter)

    render: (gram, colcounter) ->
      col = $(@el).find("#column#{colcounter}")
      div = "<div id='instaitem'>" + "<div class='instagram'>" + gram.url + "</div><div class='lat'>" + gram.coordinates[0] + "</div>" + "<div class='lon'>" + gram.coordinates[1] + "</div></div>"
      col = $(col).prepend(div)
      new Marker(gram, @icon)
