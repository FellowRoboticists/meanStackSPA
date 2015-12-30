"use strict"

angular

  .module( "app.user" )

  .controller( "ListUsersCtrl", ($state, User, $uibModal, Collection, SessionFactory, $interpolate, loader, PAGINATION_LIMIT, MESSAGES) ->

    vm = @

    vm.PAGINATION_LIMIT = PAGINATION_LIMIT
    vm.manageUsers = SessionFactory.user.permissions.manageUsers
    vm.loader = loader

    #
    # Redirect user to profile if no user management permissions
    $state.go("app.profile.edit") unless SessionFactory.user.permissions.manageUsers

    #
    # Get users
    __loadUsers = ->
      loader.activate("Loading Users...")
      User
        .query()
        .then( (users) ->
          vm.users = new Collection.fromArray(users).sortBy("name")
        ,(error) ->
          NotificationsFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.RETRIEVE)({name:"Users"})
          )
        )
        .finally( ->
          loader.deactivate()
        )

    #
    # Load users on initial page load
    __loadUsers()

    #
    # Open delete confirmation modal
    vm.confirmDelete = (user) ->
      modal = $uibModal.open(
        templateUrl:"delete-user.html"
        controller:"DeleteUserCtrl as userCtrl"
        windowClass: "modal-danger"
        resolve:
          selectedUser: -> user
      )
      modal.result.then( __loadUsers )

    #
    # Confirm terms reset
    vm.confirmTermsReset = ->
      modal = $uibModal.open(
        templateUrl:"terms-reset.html"
        controller:"TermsResetCtrl as termsCtrl"
        windowClass: "modal-danger"
      )

    return

  )
