"use strict"

angular

  .module( "app.services" )

  .service( "CollectionFactory", ($rootScope, $filter, $q, _) ->
  
    class CollectionFactory

      constructor: (collection, options) ->
        if angular.isArray(collection)
          @records = collection
          @model = collection[0]?.constructor or null
        else
          @records = []
          @model = collection or null
        @sortKey = options?.sortKey or null
        @reverse = options?.reverse or false

      #
      # Enforce array of args
      _enforceArgsArray: (args) ->
        return false unless args?
        if args.id? then args = [args.id]
        angular.isArray(args) or args = [args]
        args

      #
      # Enforce model instace on records
      _enforceModelInstance: (record) ->
        if @model? and ! (record instanceof @model)
          record = new @model(record)
        record

      #
      # Set collection records
      set: (records) ->
        return unless angular.isArray(records)
        record = @_enforceModelInstance(record) for record in records
        @clear()
        @records = records
        @sort()

      #
      # Update record in collection
      updateRecord: (record) ->
        return unless record.id?
        record = @_enforceModelInstance(record)
        if (index = @records.indexOf( @find({"id":record.id}) )) > -1
          @records[index] = angular.copy( @_enforceModelInstance(record) )

      #
      # Clear collection records
      clear: ->
        @records.length = 0
        @

      #
      # Sort by provided key
      sortBy: (sortKey) ->
        if @sortKey is sortKey
          @reverse = !@reverse
        else
          @reverse = false
          @sortKey = sortKey
        @sort()

      #
      # Sort with current key
      sort: ->
        return unless @sortKey?
        #@records = $filter("orderBy")(@records, @sortKey, @reverse)
        @records = $filter("orderBy")(@records, $rootScope.natural(@sortKey), @reverse)
        @

      #
      # Return record at index
      atIndex: (index) ->
        @records[index]

      #
      # Add record to collection
      add: (record) ->
        return unless record.id?
        record = @_enforceModelInstance(record)
        @records.push( record ) unless @find( {"id":record.id} )
        @sort()

      #
      # Delete record(s) from collection
      delete: (args) ->
        return unless args = @_enforceArgsArray(args)
        for item in args
          _.remove(@records, (record) ->
            record.id is (item.id or item)
          )

      #
      # Select provided record(s)
      select: (args) ->
        return unless args = @_enforceArgsArray(args)
        col = @
        $q( (resolve, reject) ->
          col.each( (record) ->
            for item in args
              if (item.id or item) is record.id
                record.$$selected = true
          )
          resolve(col.records)
        )

      #
      # Deselect provided record(s)
      deselect: (args) ->
        return unless args = @_enforceArgsArray(args)
        col = @
        $q( (resolve, reject) ->
          col.each( (record) ->
            for item in args
              if (item.id or item) is record.id
                record.$$selected = false
          )
          resolve(col.records)
        )

      #
      # Select all records
      selectAll: ->
        records = @records
        $q( (resolve) ->
          r.$$selected = true for r in records
          resolve(records)
        )

      #
      # Deselect all records
      deselectAll: ->
        records = @records
        $q( (resolve) ->
          r.$$selected = false for r in records
          resolve(records)
        )

      #
      # Iterate records and apply callback
      each: (cb) ->
        return unless typeof cb is "function"
        records = @records
        $q( (resolve) ->
          cb(r,i) for r,i in records
          resolve(records)
        )

      #
      # Get first record in collection
      first: ->
        @records[0]

      #
      # Get last record in collection
      last: ->
        @records[ @records.length - 1 ]

      #
      # Get next record in collection
      next: (record) ->
        index = @records.indexOf( @find({"id":record.id}) ) + 1
        @records[index]

      #
      # Get previous record in collection
      previous: (record) ->
        index = @records.indexOf( @find({"id":record.id}) ) - 1
        @records[index]

      #
      # Get index for record
      indexOf: (record) ->
        @records.indexOf( @find({"id":record.id}) )

      #
      # Contains records?
      isEmpty: ->
        @records.length is 0

      # https://lodash.com/docs#where
      where: (props) ->
        _.where( @records, props )

      # https://lodash.com/docs#pluck
      pluck: (property) ->
        _.pluck( @records, property )

      # https://lodash.com/docs#contains
      contains: (target, index) ->
        _.contains( @records, target, index )

      # https://lodash.com/docs#uniq
      unique: (sorted, callback, thisArg) ->
        _.uniq( @records, sorted, callback, thisArg )

      # https://lodash.com/docs#find
      find: (predicate, thisArg) ->
        _.find( @records, predicate, thisArg )
  )
