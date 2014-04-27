define ['backbone', 'views/map'], (Backbone, Map) ->
  class DivvyView extends Backbone.View

    initialize: (divvy) ->
      latlng = new google.maps.LatLng(divvy.coordinates[0], divvy.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: divvy.icon
      )

      options = { content: "#{divvy.station_name} <br> Available Bikes: #{divvy.available_bikes} <br> Available Docks: #{divvy.available_docks}", 
      maxWidth: 200 }

      window = new google.maps.InfoWindow(options)

      google.maps.event.addListener point, "mouseover", (e) ->
        window.open Map.get(), point

      google.maps.event.addListener point, "mouseout", (e) ->
        window.close()

      google.maps.event.addListener point, "click", (e) ->
        window.open Map.get(), point




