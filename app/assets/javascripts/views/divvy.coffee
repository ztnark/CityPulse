define ['backbone', 'views/map'], (Backbone, Map) ->
  class DivvyView extends Backbone.View

    initialize: (divvy) ->
      latlng = new google.maps.LatLng(divvy.coordinates[0], divvy.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: divvy.icon
      )




