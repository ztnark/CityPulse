define ['models/map', 'views/map'], (Map, MapView) ->
  console.log 'in router.coffee'
  class Router extends Backbone.Router
    console.log 'in router class'
    appRoutes:
      "": "index"
