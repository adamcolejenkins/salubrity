@salubrity #app

.directive "format", [
  "$filter"
  ($filter) ->

    return (
      restrict: "EA"
      require: "ngModel"
      link: ($scope, $el, attrs, ngModel, ctrl) ->
        $scope.$watch "survey.title", (val) ->
          if typeof val isnt "undefined" and typeof ngModel.$modelValue isnt "string"
            $el.val $filter(attrs.format)(val)
            $filter(attrs.format)(ngModel.$modelValue)

        ngModel.$formatters.unshift (a) ->
          $filter(attrs.format)(ngModel.$modelValue) if typeof ngModel.$modelValue isnt "undefined"

        ngModel.$parsers.unshift (viewValue) ->
          if typeof ngModel.$modelValue isnt "undefined"
            viewValue = $filter(attrs.format)(viewValue)
            $el.val viewValue
            viewValue
    )
]
