"use strict"

angular

  .module( "app.document" )

  .controller( "AddDocumentCtrl", ($state, NotificationFactory, FileUploader, maskService, $interpolate, MESSAGES) ->

    vm = @

    #
    # Initialize document to prevent write errors
    vm.document =
      name: null

    #
    # Document uploader
    vm.uploader = new FileUploader(
      url: "/documents"
      alias: "documentFile"
      formData: [vm.document]
      queueLimit: 1
      onBeforeUploadItem: (item) ->
        maskService.activate(
          $interpolate(MESSAGES.CRUD.UPLOADING)(item._file)
        )
      onAfterAddingFile: (item) ->
        vm.document = angular.extend(item.formData[0], {
          name: item._file.name.replace(".pdf", "")
          file: item._file.name
        })
      onSuccessItem: (item, response, status, headers) ->
        NotificationsFactory.successAfterTransition(
          $interpolate(MESSAGES.CRUD.SUCCESS.UPLOAD)({name: response.originalFileName})
        )
        $state.go("app.documents.list")
      onErrorItem: (item, response, status, headers) ->
        console.log("document upload error", response)
        NotificationFactory.error(
          $interpolate(MESSAGES.CRUD.ERROR.UPLOAD)({name:"Document"})
        )
      onCompleteAll: ->
        maskService.deactivate()
    )

    return
  )
