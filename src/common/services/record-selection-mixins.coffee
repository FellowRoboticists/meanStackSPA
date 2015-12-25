"use strict"

angular

  .module( "app.services" )

  .factory( "RecordSelectionMixins", ->

    @select = ->
      @$$selected = true

    @deselect = ->
      @$$selected = false

    @toggleSelected = ->
      @$$selected = !@$$selected

    @setSelected = (id, selected) ->
      if id is @id
        @$$selected = selected
      else
        false

    return @
  )