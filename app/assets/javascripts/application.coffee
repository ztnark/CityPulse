require.config
  shim:
    underscore: { exports: '_' }
    backbone: { deps: ['jquery', 'underscore'], exports: 'Backbone' }

  paths:
    jquery: '//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min'
    underscore: 'underscore-min'
    backbone: 'backbone-min'
    app: 'application'

require ['jquery', 'backbone', 'router', 'views/map', 'sockets', 'websocket_rails/main'], ($, Backbone, Router, MapView, Sockets, WebSocketRails) ->
  router = new Router
  router.bind("index", new MapView)
  twitter = new Sockets

