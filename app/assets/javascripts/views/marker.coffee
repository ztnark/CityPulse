define ['backbone', 'views/map'], (Backbone, Map) ->
  class Marker extends Backbone.View

    initialize: (data, icon) ->
      latlng = new google.maps.LatLng(data.coordinates[0], data.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: icon
        animation: google.maps.Animation.BOUNCE
      )
      options = { content: data.text,
      maxWidth: 200 }

      window = new google.maps.InfoWindow(options)

      google.maps.event.addListener point, "mouseover", (e) ->
        window.open Map.get(), point

      google.maps.event.addListener point, "mouseout", (e) ->
        window.close()

      google.maps.event.addListener point, "click", (e) ->
        window.open Map.get(), point
