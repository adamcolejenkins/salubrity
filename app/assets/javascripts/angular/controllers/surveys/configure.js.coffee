@salubrity

  .controller 'SurveyEditCtrl', 
    ($scope, Survey, $modalInstance, survey) ->

      $scope.init = -> 
        $scope.survey = survey

      $scope.proceed = (survey) ->
        $scope.survey.update(survey, survey).then -> $modalInstance.close(survey)

      $scope.close = -> 
        $modalInstance.dismiss "close"

      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")