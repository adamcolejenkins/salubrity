@salubrity
  
  .config ($routeProvider) ->

  
    $routeProvider.when '/survey/create',
      templateUrl: '/templates/surveys/create.html'
      controller: 'SurveyCreateCtrl'


  .controller 'SurveyCreateCtrl', 
    ($scope, $routeParams, $location, Survey) ->


      $scope.init = ->
        @SurveyService = new Survey(serverErrorHandler)
        $scope.siteUrl = $location.protocol() + '://' + $location.host() + '/'
        $scope.btnLabel = 'Build Survey'


      $scope.saveSurvey = (survey) ->
        @SurveyService.create survey, (survey) ->
          $location.url "/survey/#{survey.id}/build"


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")