define ['backbone', 'views/map'], (Backbone, Map) ->
  class Marker extends Backbone.View

    initialize: (point) ->
      latlng = new google.maps.LatLng(point.coordinates[0], point.coordinates[1])
      point = new google.maps.Marker(
        position: latlng
        map: Map.get()
        icon: "http://www.charlestonstems.com/wp-content/themes/stems/images/instagram_icon_22x22.png"
        animation: google.maps.Animation.BOUNCE
      )
