@salubrity
  
  .config ($stateProvider) ->
  
    $stateProvider.state 'surveys.analyze',
      url: '/survey/:id/analyze'
      templateUrl: '/templates/surveys/analyze.html'
      controller: 'SurveyAnalyzeCtrl'


  .controller 'SurveyAnalyzeCtrl', 
    ($scope, $stateParams, $location, Survey) ->


      $scope.init = ->


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")