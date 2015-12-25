"use strict"

angular

  .module( "app.login" )

  .config( ($stateProvider) ->

    $stateProvider
      .state( "app.login",
        parent: "AnonLayout"
        url: "^/login"
        templateUrl: "login.html"
        controller: "LoginCtrl as loginCtrl"
      )

  )
