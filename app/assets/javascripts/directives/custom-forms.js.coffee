@salubrity #app

.directive("icheck", ["$timeout", ($timeout) ->
  return (
    restrict: "C"
    require: "ngModel"
    link: ($scope, $el, attrs, ngModel) ->

      $timeout ->
        value = attrs.value
        $scope.$watch attrs.ngModel, (newValue) ->
          $el.iCheck "update"

        $el.iCheck(
          checkboxClass: "icheckbox_flat-green"
          radioClass: "iradio_flat-green"
        ).on "ifChanged", (event) ->

          if $el.attr("type") is "checkbox" and attrs.ngModel
            $scope.$apply -> ngModel.$setViewValue event.target.checked

          if $el.attr("type") is "radio" and attrs.ngModel
            $scope.$apply -> ngModel.$setViewValue value

  )
])

.directive "select2", ["$timeout", ($timeout) ->
  return (
    restrict: "C"
    link: (scope, iElement, iAttrs) ->
      $timeout ->
        iElement.select2(dropdownCssClass: iElement.attr("class")).css "display", "block"

  )
]
