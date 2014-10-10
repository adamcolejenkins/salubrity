@salubrity #app

.directive("icheck", ["$timeout", ($timeout) ->
  return (
    restrict: "AC"
    require: "ngModel"
    link: ($scope, $el, attrs, ngModel) ->

      $timeout ->
        style = attrs.icheck || 'flat-green'
        value = attrs.value

        $scope.$watch attrs.ngModel, (newValue) ->
          $el.iCheck "update"

        $el.iCheck(
          checkboxClass: "icheckbox_#{style}"
          radioClass: "iradio_#{style}"
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
        iElement.select2(
          dropdownCssClass: iElement.attr("class")
          width: '100%'
        ).css "display", "block"

  )
]

.directive "mask", ($timeout) ->
  return (
    restrict: 'A'
    link: (scope, elem, attrs) ->
      $timeout ->
        switch attrs.mask
          when 'date'
            elem.mask("99/99/9999")
          when 'phone'
            elem.mask("(999) 999-9999");
          when 'phone-ext'
            elem.mask("(999) 999-9999? x99999");
          when 'percent'
            elem.mask("99%");
          when 'currency'
            elem.mask("$999,999,999.99");
  )

.directive "switch", ($timeout) ->
  return (
    restrict: 'C'
    link: (scope, elem, attrs) ->
      $timeout ->
        elem.bootstrapSwitch()
  )

.directive "slider", ($timeout) ->
  return (
    restrict: 'AC'
    link: (scope, elem, attrs) ->
      $timeout ->
        elem.slider()
  )