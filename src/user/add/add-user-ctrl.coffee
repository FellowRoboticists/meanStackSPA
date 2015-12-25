"use strict"

angular

  .module( "app.user" )

  .controller( "AddUserCtrl", ($state, User, Account, NotificationsFactory, SessionFactory, Collection, $interpolate, REGEX, MESSAGES ) ->

    vm = @

    vm.REGEX = REGEX
    vm.session = SessionFactory
    vm.user = new User()

    #
    # Get accounts
    Account
      .query()
      .then( (accounts) ->
        vm.accounts = new Collection.fromArray(accounts).sortBy("name")
      ,(error) ->
        NotificationsFactory.error(
          $interpolate(MESSAGES.CRUD.ERROR.RETRIEVE)({name:"Accounts"})
        )
      )

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