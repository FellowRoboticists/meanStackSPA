"use strict"

angular

  .module( "app.authinterceptor" )

  .factory( "AuthInterceptor",  ($cookies) ->

    vm = {}

    vm.request = (config) ->

      # token = SessionFactory.getToken()
      token = $cookies.get('JWT-TOKEN')

      if (token)
        config.headers =  config.headers || {}
        config.headers.Authorization = 'Bearer ' + token

      return config

    return vm
    )
