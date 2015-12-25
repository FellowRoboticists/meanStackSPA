"use strict"

angular

  .module( "app" )

  .controller("AppCtrl", ($rootScope, $http, $state, User, AuthService, SessionFactory, Collection, NotificationsFactory, $interpolate, loader, appVersion, MESSAGES) ->

    vm = @

    vm.$state = $state
    vm.session = SessionFactory
    vm.loader = loader
    vm.appVersion = appVersion

    #
    # Let's blow this popcicle stand...
    vm.logout = ->
      AuthService.logout().then( (response) ->
        NotificationsFactory.successAfterTransition( MESSAGES.LOGOUT_SUCCESS )
        $state.go("app.login")
      , (error) ->
        NotificationsFactory.error MESSAGES.LOGOUT_ERROR
      )

    return
  )
