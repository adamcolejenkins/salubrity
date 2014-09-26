@salubrity
  
  .config ($routeProvider) ->

  
    $routeProvider.when '/survey/:id/configure',
      templateUrl: '/templates/surveys/edit.html'
      controller: 'SurveyConfigureCtrl'


  .controller 'SurveyConfigureCtrl', 
    ($scope, $routeParams, $location, Survey) ->


      $scope.init = ->
        @SurveyService = new Survey(serverErrorHandler)
        $scope.survey = @SurveyService.find $routeParams.id
        $scope.siteUrl = $location.protocol() + '://' + $location.host() + '/'
        $scope.btnLabel = 'Save Survey'


      $scope.saveSurvey = (survey) ->
        @SurveyService.update survey, (survey) ->
          $location.url "/surveys"


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")