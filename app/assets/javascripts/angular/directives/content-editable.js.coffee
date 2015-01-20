@salubrity
  
  .directive 'contentEditable', ($parse) ->
    require: 'ngModel'
    link: ($scope, $element, $attributes, ngModel) ->

      # console.log $scope, $attributes, ngModel

      read = ->
        ngModel.$setViewValue $element.html()
        return

      write = ->
        $parse($attributes.onsave)($scope,
          $data: ngModel.$viewValue
        ) unless ngModel.$viewValue is null or ngModel.$untouched

      ngModel.$render = ->
        $element.addClass 'editable-empty' if ngModel.$viewValue is null
        $element.html ngModel.$viewValue or $attributes.emptyValue or ""
        return

      $element.bind 'blur keyup change', ->
        write() if $attributes.onsave
        $element.removeClass 'editable-empty' unless ngModel.$viewValue is null
        $scope.$apply read
        return

      return


  .directive "outsideClick", [
    "$document"
    "$parse"
    ($document, $parse) ->
      return link: ($scope, $element, $attributes) ->
        scopeExpression = $attributes.outsideClick
        onDocumentClick = (event) ->
          isChild = $element.find(event.target).length > 0
          $scope.$apply scopeExpression  unless isChild
          return

        $document.on "click", onDocumentClick
        $element.on "$destroy", ->
          $document.off "click", onDocumentClick
          return

        return
  ]