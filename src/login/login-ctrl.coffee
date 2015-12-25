"use strict"

angular

  .module( "app.login" )

  .controller("LoginCtrl", ($rootScope, $state, AuthService, NotificationsFactory, $interpolate, REGEX, LOGIN)->

    vm = @

    vm.REGEX = REGEX

    vm.login = (credentials) ->
      AuthService
        .login(credentials)
        .then( (session) ->
          if session.locked
            AuthService.logout()
            if session.user.locked then item = "profile" else item = "account"
            NotificationsFactory.error(
              $interpolate(LOGIN.MESSAGES.LOCKED)({name:item})
            )
          else
            $state.go("app.books.list")
        , (error) ->
          NotificationsFactory.error(LOGIN.MESSAGES.BAD_CREDENTIALS)
        )

    return
  )