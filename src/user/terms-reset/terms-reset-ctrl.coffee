"use strict"

angular

  .module( "app.user" )

  .controller( "TermsResetCtrl", ($uibModalInstance, NotificationsFactory, User) ->

    vm = @

    # Reset terms
    vm.reset = ->
      User.resetTerms()
        .then( ->
          NotificationsFactory.success("Terms of Service reset successfully!")
        , ->
          NotificationsFactory.error("Terms of Service could not be reset. Please reload the page and try again.")
        )
        .then( $uibModalInstance.close )

    # Cancel delete
    vm.cancel = ->
      $uibModalInstance.dismiss("cancel")

    return
  )