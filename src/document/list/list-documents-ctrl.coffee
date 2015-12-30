"use strict"

angular

  .module( "app.document" )

  .controller( "ListDocumentsCtrl", ($state, Document, Collection, SessionFactory, NotificationsFactory, $interpolate, $uibModal, loader, PAGINATION_LIMIT, MESSAGES) ->

    vm = @

    vm.PAGINATION_LIMIT = PAGINATION_LIMIT
    vm.loader = loader

    #
    # Get documents
    __loadDocuments = ->
      loader.activate("Loading Documents...")
      Document
        .query()
        .then( (documents) ->
          vm.documents = new Collection.fromArray(documents).sortBy("name")
        ,(error) ->
          NotificationsFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.RETRIEVE)({name:"Documents"})
          )
        )
        .finally( ->
          loader.deactivate()
        )

    #
    # Load documents on initial page load
    __loadDocuments()

    #
    # Confirm deletion of document
    vm.confirmDelete = (document) ->
      modal = $uibModal.open(
        templateUrl: "delete-document.html"
        controller: "DeleteDocumentCtrl as documentCtrl"
        windowClass: "modal-danger"
        resolve:
          selectedDocument: -> document
      )
      modal.result.then( __loadUsers )

    return
  )
