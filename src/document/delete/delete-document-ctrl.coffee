"use strict"

angular

  .module( "app.document" )

  .controller( "DeleteDocumentCtrl", ($uibModalInstance, NotificationsFactory, Document, selectedDocument, $interpolate, MESSAGES) ->

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
          NotificationsFactory.success(
            $interpolate(MESSAGES.CRUD.SUCCESS.DELETE)({ name: document.name })
          )
          $uibModalInstance.close(document)
        ,(error) ->
          NotificationsFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.DELETE)({name:"Document"})
          )
          $uibModalInstance.close(error)
        )

    Object.defineProperties(@,
      'validDocumentNameMatch':
        get: ->
          @matchDocumentName is @document.name
    )

    #
    # Cancel delete
    vm.cancel = ->
      $uibModalInstance.dismiss("cancel")

    return
  )
