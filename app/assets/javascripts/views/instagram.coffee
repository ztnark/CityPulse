define ['backbone', 'views/marker', 'views/map'], (Backbone, Marker, Map) ->
  class InstagramView extends Backbone.View
    el: $("#instafeed")
    icon: "assets/rsz_1instagram_icon_large.png"

    events:
      "click #instaitem": "center"

    initialize: (gram, colcounter) ->
      @render(gram, colcounter)

    render: (gram, colcounter) ->
      col = $("#instafeed").find("#column#{colcounter}")
      div = "<div id='instaitem'>" + "<div class='instagram' id=#{gram.div_id}>" + gram.url + "</div><div class='lat'>" + gram.coordinates[0] + "</div>" + "<div class='lon'>" + gram.coordinates[1] + "</div></div>"
      col = $(col).prepend(div)
      new Marker(gram, @icon)


    center: (event) ->
      event.preventDefault()
      lat = $(event.currentTarget).find('.lat')[0].innerText
      long = $(event.currentTarget).find('.lon')[0].innerText
      Map.get().setCenter(new google.maps.LatLng(lat,long))
      Map.get().setZoom(15)

