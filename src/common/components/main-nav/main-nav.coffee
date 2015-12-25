"use strict"

angular

  .module("app.components")

  .directive("mainNav", ->
    restrict: "E"
    replace: true
    transclude: true
    templateUrl: "main-nav.html"
  )
