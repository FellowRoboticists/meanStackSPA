"use strict"

angular

  .module( "app" )

  .config( ($httpProvider, $urlRouterProvider, $stateProvider, $compileProvider, $logProvider, RailsResourceProvider, railsSerializerProvider, paginationTemplateProvider) ->

    $httpProvider.interceptors.push("AuthInterceptor")

    #
    # Resource model configs
    railsSerializerProvider
      .underscore(angular.identity)
      .camelize(angular.identity)
    RailsResourceProvider
      .rootWrapping(false)
      .underscoreParams(false)

    #
    # App root state
    $stateProvider
      .state(
        name: "AnonLayout"
        templateUrl: "anon-layout.html"
      )
      .state(
        name: "AuthLayout"
        templateUrl: "auth-layout.html"
      )
      .state( "app", 
        abstract: true
        controller: "AppCtrl as app"
      )

    #
    # Routes
    $urlRouterProvider
      .when("","/users")
      .when("/", "/users")
      .otherwise("/404")

    #
    # Delay digest cycle when multiple async calls made to improve performance
    $httpProvider.useApplyAsync(true)

    #
    # Custom pagination template
    paginationTemplateProvider.setPath("paginate.html")

    #
    # Disable debug mode on "meanstackspa.com" domains for better performance
    if RegExp("meanstackspa.com", "i").test(window.location.host)
      # Don't add angular debug params to DOM elements
      $compileProvider.debugInfoEnabled(false)
      # Disable console logging
      $logProvider.debugEnabled(false)

  )
