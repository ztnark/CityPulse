define ['backbone', 'views/map'], (Backbone, Map) ->
  class TrainView extends Backbone.View

    initialize: (train) ->
      latlng = new google.maps.LatLng(train.coordinates[0], train.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: train.icon
      )

