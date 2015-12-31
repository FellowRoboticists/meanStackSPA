"use strict"

angular

  .module("app.components")

  .directive("mask", ->
    restrict: "E"
    replace: true
    templateUrl: "mask.html"
    controller: "MaskCtrl"
    controllerAs: "mask"
    bindToController: true
  )

  .controller( "MaskCtrl", (maskService) ->

    vm = @

    vm.svc = maskService

    return
  )

  .service( "maskService", () ->

    @active = false

    @spinner = @message = null

    @set = (active) ->
      @active = active

    @activate = (message=null, spinner=true) ->
      @spinner = spinner ? true
      @message = message ? message
      @set(true)

    @deactivate = ->
      @set(false)
      @spinner = @message = null

    return
  )