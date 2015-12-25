"use strict"

angular

  .module( "app.auth" )

  .service( "AuthService", ( $rootScope, $http, SessionFactory ) ->

    login: (credentials) ->
      $http
        .post( "/session", credentials )
        .then( (response) ->
          SessionFactory.create(response.data).then( (session) ->
            $rootScope.$emit("user:login", session)
            return session
          )
        )

    logout: ->
      $http
        .delete( "/session" )
        .finally( ->
          SessionFactory.destroy().then( (session) ->
            $rootScope.$emit("user:logout", session)
            return session
          )
        )

  )
