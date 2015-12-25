"use strict"

angular

  .module("app.components")

  .directive("headerActions", ->
    restrict: "E"
    replace: true
    transclude: true
    templateUrl: "header-actions.html"
  )
