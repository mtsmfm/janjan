#= require action_cable

@App = {}
App.cable = ActionCable.createConsumer "ws://#{window.location.host}/cable"
