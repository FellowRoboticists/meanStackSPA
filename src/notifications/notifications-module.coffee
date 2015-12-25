"use strict"

angular

  .module( "app.notifications", [
    "ngSanitize"
  ])

  .directive( "notifications", ->
    restrict: "E"
    replace: true
    templateUrl: "notifications.html"
    controller: "NotificationsCtrl"
    controllerAs: "notifications"
    bindToController: true
  )

  .controller( "NotificationsCtrl", (NotificationsFactory, NOTIFICATIONS) ->

    vm = @

    vm.types = NOTIFICATIONS.ICONS

    vm.factory = NotificationsFactory

    return
  )
