"use strict"

angular

  .module( "app.services" )

  .provider( "debug", ->

    url = "/error_log"

    setApiUrl: (url) ->
      url = url

    $get: ($http, $location, $log, deviceDetector, SessionFactory) ->

      #
      # Return plain JSON without methods or cyclical references
      __sanitize = (unsanitaryObj) ->
        JSON.parse JSON.stringify JSON.decycle unsanitaryObj

      #
      # Capture snapshot
      getSnapshot: (error, data={}) ->
        snapshot = {}
        try
          angular.extend(snapshot,
            error: __sanitize(error)
            data: __sanitize(data)
            path: $location.url()
            session: SessionFactory.toJSON()
            browser: deviceDetector.browser
            browser_version: deviceDetector.browser_version
            os: deviceDetector.os
            os_version: deviceDetector.os_version
            device: deviceDetector.device
            userAgent: deviceDetector.raw.userAgent
          )
        catch error
          $log.debug error
        finally
          snapshot

      #
      # Send snapshot
      send: (error, data={}) ->
        message = @getSnapshot(error, data)
        console.log("Would have sent error: %j", message);
        #try
          #$http.post(url, message)
        #catch error
          #$log.debug error
        #finally
          #$log.debug message
  )
