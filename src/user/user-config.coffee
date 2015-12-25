"use strict"

angular

  .module( "app.user" )

  .config( ($stateProvider) ->

    $stateProvider

      # Root
      .state( "app.users",
        parent: "AuthLayout"
        abstract: true
        template: "<ui-view/>"
      )

      # List
      .state( "app.users.list",
        url: "^/users"
        templateUrl: "list-users.html"
        controller: "ListUsersCtrl as usersCtrl"
      )

      # Add
      .state( "app.users.add",
        url: "^/users/add"
        templateUrl: "add-user.html"
        controller: "AddUserCtrl as userCtrl"
      )

      # Edit
      .state( "app.users.edit",
        url: "^/users/{userId:[0-9a-fA-F]{24}}/edit"
        templateUrl: "edit-user.html"
        controller: "EditUserCtrl as userCtrl"
      )

  )
