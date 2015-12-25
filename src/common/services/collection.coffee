'use strict'

angular

  .module( "app.services" )

  .factory( "Collection", ($locale) ->

    # http://www.bennadel.com/blog/2292-extending-javascript-arrays-while-keeping-native-bracket-notation-functionality.htm
    Collection = ->
      collection = Object.create(Array.prototype)
      collection = Array.apply(collection, arguments) or collection
      Collection.injectClassMethods collection
      collection
  
    Collection.injectClassMethods = (collection) ->
      for method of Collection.prototype
        if Collection::hasOwnProperty(method)
          collection[method] = Collection.prototype[method]
      collection
  
    Collection.fromArray = (array) ->
      collection = Collection.apply(null, array)
      collection
  
    Collection.isArray = (value) ->
      stringValue = Object::toString.call(value)
      stringValue.toLowerCase() is '[object array]'

    Collection.prototype =

      add: (value) ->
        if ! @where({id:value.id}).length
          @push(value)
        @

      delete: (value) ->
        collection = @
        collection.forEach( (item, i) ->
          if item.id is value.id
            collection.splice(i, 1)
        )

      addAll: ->
        @add item for item in arguments
        @

      last: ->
        @[@length-1]

      select: (value) ->
        for item,i in @
          if item.id is value.id
            item.$$selected = true

      deselect: (value) ->
        for item,i in @
          if item.id is value.id
            item.$$selected = false

      selectAll: ->
        item.$$selected = true for item in @
        @

      deselectAll: ->
        item.$$selected = false for item in @
        @

      # https://lodash.com/docs#pluck
      pluck: (attr) ->
        _.pluck(@, attr)

      # https://lodash.com/docs#where
      where: (attr) ->
        Collection.fromArray(_.where(@, attr))

      # https://lodash.com/docs#every
      every: (predicate, thisArg) ->
        _.every(@, predicate, thisArg)

      # https://lodash.com/docs#any
      any: (predicate, thisArg) ->
        _.any(@, predicate, thisArg)

      # https://lodash.com/docs#at
      at: (props) ->
        _.at(@, props)

      replace: (record) ->
        for item,i in @
          if item.id is record.id then @[i] = record

      # https://bitbucket.org/OverZealous/angularjs-naturalsort
      sortBy: (sortKey, reverseSort=false) ->

        padding = (value) ->
          '00000000000000000000'.slice value.length
    
        toString = (value) ->
          if !value? then return ''
          return "#{value}"
    
        natDateMonthFirst = $locale.DATETIME_FORMATS.shortDate.charAt(0) is 'M'
    
        fixDates = (value) ->
          toString(value).replace( /(\d\d?)[-\/\.](\d\d?)[-\/\.](\d{4})/, ($0, $m, $d, $y) ->
            t = $d
            if !natDateMonthFirst
              if Number($d) < 13
                $d = $m
                $m = t
            else if Number($m) > 12
              $d = $m
              $m = t
            "#{$y}-#{$m}-#{$d}"
          )
    
        fixNumbers = (value) ->
          value.replace( /(\d+)((\.\d+)+)?/g, ($0, integer, decimal, $3) ->
            if decimal isnt $3
              $0.replace /(\d+)/g, ($d) ->
                padding($d) + $d
            else
              decimal = decimal or '.0'
              padding(integer) + integer + decimal + padding(decimal)
          )
    
        natValue = (value) ->
          fixNumbers( fixDates(value) )

        sort = (a,b) ->
          a = natValue(a[sortKey])
          b = natValue(b[sortKey])
          if a < b then -1 else if a > b then 1 else 0

        return @ unless @sortKey or sortKey

        if @sortKey is sortKey
          @reverseSort = !@reverseSort
        else
          @reverseSort = false
          @sortKey = sortKey

        if @reverseSort
          @sort(sort).reverse()
        else
          @sort(sort)
        @

    Collection

  )