"use strict"

angular

  .module( "app.notifications" )

  .factory( "NotificationsFactory", (locker, _, NOTIFICATIONS) ->

    #
    # Notifications object
    #
    # {
    #   currentRoute: {
    #     "danger": ["a message", "another message"],
    #     "warning": ["some text"]
    #   },
    #   nextRoute: {
    #     "success": ["it worked!"]
    #   },
    #   persistent: {
    #     "info": ["tomorrow we are down for maintenance"]
    #   }
    # }

    vm = @

    #
    # Message cache
    vm.notifications = locker.get( "notifications", angular.copy(NOTIFICATIONS.TEMPLATE) )

    #
    # Add message to cache
    vm.add = (messages, type, route) ->
      # overwrite currentRoute messages to prevent history from stacking up
      if route is "currentRoute" then @clear()
      # ensure type array is defined
      @notifications[route][type] ||= []
      # convert messages string to array
      angular.isArray(messages) || (messages = [messages])
      # add messages to object
      for message in messages
        if !_.contains(@notifications[route][type], message)
          @notifications[route][type].push(message)
          locker.put("notifications", @notifications)
        return

    #
    # Transfer nextRoute to currentRoute
    vm.transferRoute = ->
      if !_.isEmpty(@notifications.nextRoute)
        angular.copy(@notifications.nextRoute, @notifications.currentRoute)
        @clear("nextRoute")

    #
    # Current route
    vm.info = (messages) ->
      @add(messages, "info", "currentRoute")
    vm.success = (messages) ->
      @add(messages, "success", "currentRoute")
    vm.error = (messages) ->
      @add(messages, "danger", "currentRoute")
    vm.warning = (messages) ->
      @add(messages, "warning", "currentRoute")

    #
    # Next route
    vm.infoAfterTransition = (messages) ->
      @add(messages, "info", "nextRoute")
    vm.successAfterTransition = (messages) ->
      @add(messages, "success", "nextRoute")
    vm.errorAfterTransition = (messages) ->
      @add(messages, "danger", "nextRoute")
    vm.warningAfterTransition = (messages) ->
      @add(messages, "warning", "nextRoute")

    #
    # Persistent message
    vm.infoPersistent = (messages) ->
      @add(messages, "info", "persistent")
    vm.successPersistent = (messages) ->
      @add(messages, "success", "persistent")
    vm.dangerPersistent = (messages) ->
      @add(messages, "danger", "persistent")
    vm.warningPersistent = (messages) ->
      @add(messages, "warning", "persistent")

    #
    # Clear all messages for given route (currentRoute/nextRoute/persistent)
    vm.clear = (route="currentRoute") ->
      angular.copy({}, @notifications[route])
      locker.put("notifications", @notifications)

    #
    # Clear messages by type (success/info/warning/danger)
    vm.clearByType = (type, route="currentRoute") ->
      delete @notifications[route][type]
      locker.put("notifications", @notifications)

    return vm
  )