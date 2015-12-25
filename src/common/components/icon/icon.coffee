"use strict"

angular

  .module( "app.components" )

  .directive( "icon", ->
    restrict: "A"
    link: (scope, element, attrs) ->
      element
        .addClass("glyphicon glyphicon-#{attrs.icon}")
  )
