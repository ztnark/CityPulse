define ['models/map', 'views/map'], (Map, MapView) ->
  class Router extends Backbone.Router
    appRoutes:
      "": "index"
