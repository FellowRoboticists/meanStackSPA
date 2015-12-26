"use strict"

angular

  .module( "app.user" )

  .controller( "AddUserCtrl", ($state, User, NotificationsFactory, SessionFactory, Collection, $interpolate, REGEX, MESSAGES ) ->

    vm = @

    vm.REGEX = REGEX
    vm.session = SessionFactory
    vm.user = new User()

    vm.save = (user) ->
      user
        .save()
        .then( (user) ->
          NotificationsFactory.successAfterTransition(
            $interpolate(MESSAGES.CRUD.SUCCESS.CREATE)(user)
          )
          $state.go("app.users.list")
        , (error) ->
          NotificationsFactory.error(
            $interpolate(MESSAGES.CRUD.ERROR.CREATE)({name:"User"})
          )
        )

    return

  )
