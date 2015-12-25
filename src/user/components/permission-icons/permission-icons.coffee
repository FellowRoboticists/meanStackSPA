"use strict"

angular

  .module( "app.user" )

  .directive("permissionIcons", ->
    restrict: "E"
    replace: true
    templateUrl: "permission-icons.html"
    controller: "PermissionIconsCtrl"
    controllerAs: "permissionsCtrl"
    bindToController: true
    scope:
      user: "="
  )

  .controller( "PermissionIconsCtrl", (PERMISSIONS) ->
    vm = @
    vm.permissions = PERMISSIONS
    return
  )

  .constant("PERMISSIONS",[{
    "icon": "globe"
    "tooltip": "Account Owner"
    "attribute": "accountOwner"
  },{
    "icon": "briefcase"
    "tooltip": "Contractor"
    "attribute": "contractor"
  },{
    "icon": "user"
    "tooltip": "User Manager"
    "attribute": "userManager"
  },{
    "icon": "book"
    "tooltip": "Book Curator"
    "attribute": "bookCurator"
  },{
    "icon": "ok-circle"
    "tooltip": "Terms Accepted"
    "attribute": "termsAccepted"
  }])
