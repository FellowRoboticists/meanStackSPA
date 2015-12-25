"use strict"

angular

  .module( "app.notifications" )

  .run( ( $rootScope, NotificationsFactory ) ->

    #
    # Cycle route messages
    $rootScope.$on( "$stateChangeSuccess", (evt, toState, toParams, fromState, fromParams) ->
      NotificationsFactory.clear()
      NotificationsFactory.transferRoute()
    )

  )
