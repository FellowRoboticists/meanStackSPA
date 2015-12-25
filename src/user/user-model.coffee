'use strict'

angular

  .module( 'app.user' )

  .service( 'User', (RailsResource, SessionFactory) ->

    class User extends RailsResource

      @configure
        url: '/user'

      constructor: (data) ->
        super(data)
        @permissions ||= {}

      @resetTerms: ->
        @$post( '/user/reset_terms' )

      projects: ->
        User.$get( @$url('/project') )

      acceptTerms: ->
        @termsAccepted = true
        @update()

    Object.defineProperties(User.prototype,
      'isCurrentUser':
        get: ->
          @id is SessionFactory.user?.id
      '$$selected':
        writable: true
        value: false
      'userManager':
        get: ->
          @permissions.manageUsers
      'bookCurator':
        get: ->
          @permissions.curateBooks
    )

    User
  )
