"use strict"

angular

  .module('app.components')

  .directive("loader", ->
    restrict: 'E'
    replace: true
    scope: {}
    templateUrl: "loader.html"
    controller: "LoaderCtrl"
    controllerAs: "loader"
    bindToController: true
  )

  .controller( "LoaderCtrl", ($scope, loader, $timeout) ->

    vm = @

    vm.show = false

    vm.svc = loader

    #
    # Delay loader deactivation to prevent flash
    $scope.$watch( ->
      vm.svc.active
    , (newValue, oldValue) ->
      if newValue?
        if newValue is true
          vm.show = true
        else
          $timeout ( ->
            vm.show = false
          ), 750
    )

    return
  )

  .service( "loader", ->

    @active = false

    @activate = (@message='Loading...') ->
      @active = true

    @deactivate = ->
      @active = false

    return
  )
