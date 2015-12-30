"use strict"

angular

  .module( "app.document" )

  .config( ($stateProvider) ->

    $stateProvider

      # Root
      .state( "app.documents",
        parent: "AuthLayout"
        abstract: true
        template: "<ui-view/>"
      )

      # List 
      .state( "app.documents.list",
        url: "^/documents"
        templateUrl: "list-documents.html"
        controller: "ListDocumentsCtrl as documentsCtrl"
      )

      # Add
      .state( "app.documents.add",
        url: "^/documents/add"
        templateUrl: "add-document.html"
        controller: "AddDocumentCtrl as documentCtrl"
      )

  )
