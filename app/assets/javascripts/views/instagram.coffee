define ['backbone'], (Backbone) ->
  class InstagramView extends Backbone.View

    el: $("#instafeed")

    initialize: (gram, colcounter) ->
      @render(gram, colcounter)

    render: (gram, colcounter) ->
      col = $(@el).find("#column#{colcounter}")
      div = "<div id='instaitem'>" + "<div class='instagram'>" + gram.url + "</div><div class='lat'>" + gram.coordinates[0] + "</div>" + "<div class='lon'>" + gram.coordinates[1] + "</div></div>"
      col = $(col).prepend(div)
