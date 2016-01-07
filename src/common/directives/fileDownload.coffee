"use strict"

angular

  .module( 'app.components' )

  .directive( "fileDownload", ($http) ->
    restrict: 'EA'
    link: (scope, element, attrs) ->
      element.on('click', (event) ->
        event.preventDefault()
        href = attrs.href
        $http
          .get(href)
          .then( (response) ->
            document.location.href = "#{href}?token=#{response.data.token}"
          ,(error) ->
            alert("Error downloading document")
          )
      )
  )
