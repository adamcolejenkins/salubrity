@salubrity #app

.directive "uiTouchspin", [
  "$timeout"
  ($timeout) ->
    return (
      restrict: "EA"
      require: "ngModel"
      link: ($scope, $el, attrs, ngModel) ->

        $timeout ->
          options = angular.extend({},
            min: 0
            max: 100
            step: 1
            buttondown_class: "button prefix"
            buttonup_class: "button postfix"
          , attrs)
          el = $el.TouchSpin options

    )
]
