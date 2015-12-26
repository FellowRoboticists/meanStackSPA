"use strict"

angular

  .module( "app.user" )

  .controller( "EditUserCtrl", ($state, User, NotificationsFactory, SessionFactory, Collection, $interpolate, REGEX, MESSAGES) ->

    vm = @

    vm.REGEX = REGEX
    vm.session = SessionFactory

    #
    # Get user record
    User
      .get($state.params.userId)
      .then( (user) ->
        vm.user = user
      ,(error) ->
        NotificationsFactory.error(
          $interpolate(MESSAGES.CRUD.ERROR.RETRIEVE)({name:"User"})
        )
        $state.go("app.users.list")
      )

    #
    # Update user
    vm.save = (user) ->
      user
        .save()
        .then( (user) ->
          NotificationsFactory.successAfterTransition(
            $interpolate(MESSAGES.CRUD.SUCCESS.UPDATE)(user)
          )
          $state.go("app.users.list")
        , (error) ->
          NotificationsFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.UPDATE)({name:"User"})
          )
        )

    return

  )
