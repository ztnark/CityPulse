define ['backbone', 'views/map'], (Backbone, Map) ->
  class EventbriteView extends Backbone.View

    initialize: (eventbrite) ->
      latlng = new google.maps.LatLng(eventbrite.coordinates[0], eventbrite.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: eventbrite.icon
      )



