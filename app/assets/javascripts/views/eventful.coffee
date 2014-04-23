define ['backbone', 'views/map'], (Backbone, Map) ->
  class EventfulView extends Backbone.View

    initialize: (eventful) ->
      latlng = new google.maps.LatLng(eventful.coordinates[0], eventful.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: eventful.icon
      )


