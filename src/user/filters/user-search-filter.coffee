"use strict"

angular

  .module( "app.user" )

  .filter( "userSearchFilter", ->
    (users, text) ->

      #
      # Show all records if no search param
      if !text then return users

      #
      # Set search text to lower case
      searchQuery = angular.lowercase(text)

      #
      # Init array for filtered subset
      filteredCollection = []

      #
      # Check for 'name' match
      nameMatch = (user) ->
        name = angular.lowercase(user.name)
        name.indexOf(searchQuery) isnt -1

      #
      # Check for 'email' match
      emailMatch = (user) ->
        email = angular.lowercase(user.email)
        email.indexOf(searchQuery) isnt -1

      #
      # Parse collection
      for user in users
        if nameMatch(user) or emailMatch(user)
          filteredCollection.push(user)

      #
      # Return filtered subset
      filteredCollection
  )