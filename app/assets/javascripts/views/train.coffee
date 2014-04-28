define ['backbone', 'views/map'], (Backbone, Map) ->
  class TrainView extends Backbone.View

    initialize: (train) ->
      latlng = new google.maps.LatLng(train.coordinates[0], train.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: train.icon
      )
      options = { content: "Train: #{train.name} <br>Headed to #{train.destination}<br> Next Stop: #{train.next_stop}",
      maxWidth: 200 }
      window = new google.maps.InfoWindow(options)

      @remove_marker(point)

      google.maps.event.addListener point, "mouseover", (e) ->
        window.open @map, point

      google.maps.event.addListener point, "mouseout", (e) ->
        window.close()

      google.maps.event.addListener point, "click", (e) ->
        window.open @map, point
    
    remove_marker: (marker) ->
      setTimeout (->
        marker.setMap null
        return
      ), 14750
