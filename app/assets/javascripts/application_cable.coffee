#= require cable

@App = {}
App.cable = Cable.createConsumer "ws://#{window.location.host}/websocket"
