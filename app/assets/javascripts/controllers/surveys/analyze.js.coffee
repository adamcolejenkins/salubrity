@salubrity
  
  .config ($routeProvider) ->

  
    $routeProvider.when '/survey/:id/analyze',
      templateUrl: '/templates/surveys/analyze.html'
      controller: 'SurveyAnalyzeCtrl'


  .controller 'SurveyAnalyzeCtrl', 
    ($scope, $routeParams, $location, Survey) ->


      $scope.init = ->


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")