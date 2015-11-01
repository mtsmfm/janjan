App.cable.subscriptions.create 'WebNotificationsChannel',
  received: ->
    window.location.reload()
