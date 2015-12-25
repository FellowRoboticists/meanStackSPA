'use strict'

angular

  .module( 'app.session' )

  .run( ($rootScope, $log) ->

    $rootScope.$on('session:created', (event, session) ->
      $log.debug("Session created -> #{JSON.stringify(session, null, 2)}")
    )

    $rootScope.$on('session:destroyed', (event, session) ->
      $log.debug("Session destroyed -> #{JSON.stringify(session, null, 2)}")
    )

    $rootScope.$on('session:updated', (event, session) ->
      $log.debug("Session updated -> #{JSON.stringify(session, null, 2)}")
    )

  )