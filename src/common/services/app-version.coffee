'use strict'

angular

  .module( 'app.services' )

  .factory( 'appVersion', ( $http, $log, locker ) ->

    vm = {}

    #
    # Check version
    vm.check = ->
      $http.get('/application/version').then( (response) ->
        response.data.version
      )

    #
    # Cache version
    vm.cache = (version) ->
      vm.version = version
      locker.put('version', version)

    #
    # Extend factory with cached version on page reload
    angular.extend( vm, {version: locker.get('version')} )

    #
    # Log version to console on page reload
    $log.debug("App version -> #{vm.version}")

    return vm
  )

  .run( ($rootScope, appVersion, NotificationsFactory, $interpolate, MESSAGES) ->

    #
    # Update app
    $rootScope.$on('user:logout', (event, session) ->
      appVersion.check().then( (version) ->
        if appVersion.version isnt version
          appVersion.cache(version)
          NotificationsFactory.infoAfterTransition(
            $interpolate(MESSAGES.NEW_VERSION)({version:version})
          )
          window.location.reload(true)
      )
    )

  )