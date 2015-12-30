"use strict"

angular

  .module( "app.document" )

  .controller( "DeleteDocumentCtrl", ($uibModalInstance, NotificationFactory, Document, selectedDocument, $interpolate, MESSAGES) ->

    vm = @

    #
    # Expose record to view
    vm.document = new Document(selectedDocument)

    #
    # Delete the document
    vm.delete = ->
      vm.document
        .delete()
        .then( (document) ->
          NotificationFactory.success(
            $interpolate(MESSAGES.CRUD.DELETE)(document)
          )
          $uibModalInstance.close(document)
        ,(error) ->
          NotificationFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.DELETE)({name:"Document"})
          )
          $uibModalInstance.close(error)
        )

    #
    # Cancel delete
    vm.cancel = ->
      $uibModalInstance.dismiss("cancel")

    return
  )
