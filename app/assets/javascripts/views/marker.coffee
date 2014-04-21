define ['backbone', 'views/map'], (Backbone, Map) ->
  class Marker extends Backbone.View

    initialize: (point, icon) ->
      latlng = new google.maps.LatLng(point.coordinates[0], point.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: icon
        animation: google.maps.Animation.BOUNCE
      )
