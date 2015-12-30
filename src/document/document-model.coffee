"use strict"

angular

  .module( "app.document" )

  .service( "Document", (RailsResource, SessionFactory) ->

    class Document extends RailsResource

      @configure
        url: '/documents'

      constructor: (data) ->
        super(data)

    Document
  )
