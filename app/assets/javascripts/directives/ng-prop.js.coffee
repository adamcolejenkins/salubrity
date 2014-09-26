@salubrity #app

.directive "ngProp", [
  "$filter"
  ($filter) ->
    return (
      restrict: "A"
      link: ($scope, $el, attrs) ->
        $scope.field.properties = $filter('fieldTypeSearch')('type', $scope.field.field_type)
    )
]
