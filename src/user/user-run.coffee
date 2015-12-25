"use strict"

angular

  .module( "app.user" )

  .run( ( $log, $state, NotificationsFactory, SessionFactory, AuthService, socket, _, debug, $interpolate, USER ) ->


    #
    # Log out user if session terminated
    socket.on("user:logged_out", (sessionsObj) ->
      return false unless SessionFactory.isValid
      $log.debug "Logout blast: #{JSON.stringify(sessionsObj)}"
      if !!sessionsObj.numSessions and _.contains(sessionsObj.sessions, SessionFactory.sessionId)
        debug.send("user:logged_out",{error:"user:logged_out"})
        AuthService.logout().then( (response) ->
          NotificationsFactory.warningAfterTransition( USER.MESSAGES.DUPLICATE_LOGIN )
          $state.go("app.login")
        )
    )

    #
    # Log out user if profile is locked
    socket.on("user:locked", (userId) ->
      return false unless SessionFactory.isValid
      $log.debug "User lock blast: #{userId}"
      if SessionFactory.user.id is userId
        AuthService.logout().then( (response) ->
          NotificationsFactory.warningAfterTransition( USER.MESSAGES.PROFILE_LOCKED )
          $state.go("app.login")
        )
    )

  )
