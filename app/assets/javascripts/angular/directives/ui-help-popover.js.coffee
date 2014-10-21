@salubrity #app

.directive "ngHelp", [
  "$timeout"
  ($timeout) ->
    return (
      restrict: "E"
      replace: true
      templateUrl: "partials/helpPopover.html"
      link: ($scope, $el, attrs) ->
        $scope.title = attrs.title
        $scope.description = attrs.description
        $scope.placement = attrs.placement or "right"
    )
]
