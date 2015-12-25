'use strict'

angular

  .module( 'app.session' )

  .factory( 'SessionFactory', ( $rootScope, $q, $log, locker ) ->

    __storageKey = 'session'

    vm = {}

    #
    # Create session
    vm.create = (sessionData) ->
      __cache(sessionData, 'created')

    #
    # Update session user
    vm.updateUser = (userData) ->
      __cache({user: userData}, 'updated')

    #
    # Destroy session
    vm.destroy = ->
      session = @
      $q( (resolve) ->
        ['version','jwtToken','user'].forEach( (attr) ->
          delete session[attr]
        )
        locker.forget(__storageKey)
        __emit('destroyed', session)
        resolve(session)
      )

    #
    # Cache session in local storage
    __cache = (session, event) ->
      $q( (resolve) ->
        newSession = angular.extend( vm, session )
        locker.put(__storageKey, newSession)
        __emit(event, newSession) unless ! event?
        resolve(newSession)
      )

    #
    # Emit event
    __emit = (event, session) ->
      $rootScope.$emit("session:#{event}", session)

    #
    # Accessors/mutators
    Object.defineProperties(vm,
      'isValid':
        get: ->
          @jwtToken?
        enumerable: true
    )

    #
    # Enforce schema
    vm.toJSON = ->
      return {} unless @isValid
      'version': @version
      'jwtToken': @jwtToken
      'user': @user

    #
    # Extend factory with cached session on page reload
    angular.extend( vm, locker.get(__storageKey) )

    #
    # Log current session to console on page reload
    $log.debug("Current session -> #{JSON.stringify(vm, null, 2)}")

    return vm
  )
