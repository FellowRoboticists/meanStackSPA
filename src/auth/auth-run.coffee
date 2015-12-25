"use strict"

angular

  .module( "app.auth" )

  .run( ($rootScope, $state, NotificationsFactory, SessionFactory, AuthService, debug, AUTH) ->

    #
    # Skip login if authenticated, otherwise => #/login
    $rootScope.$on( "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
      if SessionFactory.isValid
        if toState.name is "app.login"
          event.preventDefault()
          $state.go("app.books.list")
      else
        if toState.name isnt "app.login"
          event.preventDefault()
          $state.go("app.login")
    )

    #
    # Alert for unauthorized route
    $rootScope.$on( "request-unauthorized", (event, data) ->
      debug.send("unauthorized/expired session", data)
      AuthService
        .logout()
        .then( ->
          NotificationsFactory.errorAfterTransition( AUTH.MESSAGES.EXPIRED )
          $state.go("app.login")
        )
    )

  )
