@salubrity

.directive "ngUnique", [
  "Survey"
  "$auth"
  (Survey, $auth) ->
    return (
      restrict: "EA"
      require: "ngModel"
      link: ($scope, $el, attrs, ngModel) ->

        $el.on "blur", (event) ->
          $scope.$apply ->

            @val = $el.val()

            if @val isnt "" and $auth.validateUser
              Survey.unique(attrs.ngUnique, @val)
                .then (response) -> ngModel.$setValidity "unique", not response.data.exists
    )
]
