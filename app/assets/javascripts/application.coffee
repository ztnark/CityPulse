require.config
  shim:
    underscore: { exports: '_' }
    backbone: { deps: ['jquery', 'underscore'], exports: 'Backbone' }

  paths:
    jquery: '//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min'
    underscore: 'underscore-min'
    backbone: 'backbone-min'
    app: 'application'

require ['jquery', 'backbone', 'router', 'views/map', 'sockets'], ($, Backbone, Router, MapView, Sockets) ->
  router = new Router
  router.bind("index", new MapView)
  twitter = new Sockets
  alert "The app has started with requirejs. yay!!"

