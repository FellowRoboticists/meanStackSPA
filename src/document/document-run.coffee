"use strict"

angular

  .module( "app.document" )

  .run( ($log, socket) ->

    socket.on("document:uploaded", (uploadObj) ->
      $log.debug "Document Uploaded: #{JSON.stringify(uploadObj)}"
    )

  )
