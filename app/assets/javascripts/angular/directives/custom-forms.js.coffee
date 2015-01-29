@salubrity #app

.directive("icheck", ["$timeout", ($timeout) ->
  return (
    restrict: "C"
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

# .directive "select2", ["$timeout", ($timeout) ->
#   return (
#     restrict: "C"
#     link: (scope, elem, attrs) ->
#       $timeout ->
#         elem.select2(
#           placeholder: attrs.title
#           dropdownCssClass: elem.attr("class")
#           width: '100%'
#         ).css "display", "block"

#   )
# ]

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

.directive 'csSelect', ($timeout) ->
  return (
    restrict: 'C'
    link: (scope, elem, attrs) ->
      elem
        .find( 'option:first-child' )
        .attr('disabled', 'disabled')
        .text( attrs.placeholder )

      new SelectFx elem[0],
        classes:
          baseClass:        "cs-select"
          styleClass:       "cs-skin-border"
          selectedClass:    "cs-selected"
          placeholderClass: "cs-placeholder"
          optgroupClass:    "cs-optgroup"
          optionsClass:     "cs-options"
          focusClass:       "cs-focus"
          activeClass:      "cs-active"
          mobileClass:      "cs-mobile"
        onChange: (val) -> 
          elem.val(val)
  )