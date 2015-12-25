"use strict"

angular

  .module( "app.errors" )

  .run( ($rootScope, NotificationsFactory, debug) ->

    #
    # Alert for http 50* server errors
    $rootScope.$on( "server-error", (event, data) ->
      NotificationsFactory.error("We're sorry, but there was an error on the server. Please try again later.")
    )

    #
    # Log all errors
    $rootScope.$on( "log-error", (event, data) ->
      debug.send("log-error", data)
    )

  )
