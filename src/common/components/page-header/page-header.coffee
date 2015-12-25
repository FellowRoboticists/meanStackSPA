"use strict"

angular

  .module("app.components")

  .directive("pageHeader", ->
    restrict: "E"
    replace: true
    transclude: true
    templateUrl: "page-header.html"
    scope:
      header: "@"
      headerSmall: "@"
      back: "@"
      backLabel: "@"
  )
