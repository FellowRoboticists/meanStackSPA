"use strict"

angular

  .module("app.components")

  .directive( "javascriptEnabled", ->
    restrict: "C"
    link: (scope, elem, attr) ->
      elem.css("display", "block")
  )