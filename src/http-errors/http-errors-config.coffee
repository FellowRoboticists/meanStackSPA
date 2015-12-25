"use strict"

angular

  .module( "app.errors" )

  .config( ($httpProvider, $stateProvider) ->

    $httpProvider.interceptors.push( "httpErrorInterceptor" )

    $stateProvider

      # Root
      .state("app.errors",
        parent: "AnonLayout"
        abstract: true
        template: "<ui-view></ui-view>"
      )

      # 404 Error
      .state("app.errors.404",
        url: "^/404"
        templateUrl: "404.html"
      )

  )

  .factory( "httpErrorInterceptor", ( $rootScope, $q ) ->
    responseError: (rejection) ->
      $rootScope.$emit( "log-error", rejection)
      if (/40(1|3)/).test(rejection.status)
        $rootScope.$emit( "request-unauthorized", rejection )
      if (/50(0-5)/).test(rejection.status)
        $rootScope.$emit( "server-error", rejection )
      $q.reject(rejection)
  )
