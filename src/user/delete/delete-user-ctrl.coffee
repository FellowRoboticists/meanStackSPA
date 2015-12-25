"use strict"

angular

  .module( "app.user" )

  .controller( "DeleteUserCtrl", ($uibModalInstance, NotificationsFactory, User, selectedUser, $interpolate, MESSAGES) ->

    vm = @

    #
    # Expose record to view
    vm.user = new User(selectedUser)

    #
    # Delete record
    vm.delete = ->
      vm.user
        .delete()
        .then( (user) ->
          NotificationsFactory.success(
            $interpolate(MESSAGES.CRUD.SUCCESS.DELETE)(user)
          )
          $uibModalInstance.close(user)
        ,(error) ->
          NotificationsFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.DELETE)({name:"User"})
          )
          $uibModalInstance.close(error)
        )

    #
    # Cancel delete
    vm.cancel = ->
      $uibModalInstance.dismiss("cancel")

    return
  )