"use strict"

angular

  .module( "app.auth" )

  .service( "AuthService", ( $rootScope, $http, SessionFactory ) ->

    login: (credentials) ->
      $http
        .post( "/token", credentials )
        .then( (response) ->
          SessionFactory.create(response.data).then( (session) ->
            $rootScope.$emit("user:login", session)
            return session
          )
        )

    logout: ->
      $http
        .delete( "/token" )
        .finally( ->
          SessionFactory.destroy().then( (session) ->
            $rootScope.$emit("user:logout", session)
            return session
          )
        )

    sendMessage: ->
      $http
        .post( "/messages", { msg: "Just Say It" })
        .then( (response) ->
          console.log("Got response: %j", response)
        )

  )
