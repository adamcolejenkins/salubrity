@salubrity
  
  .config ($stateProvider) ->

  
    $stateProvider.state 'surveys.configure',
      url: '/:id/configure'
      templateUrl: '/templates/surveys/edit.html'
      controller: 'SurveyConfigureCtrl'


  .controller 'SurveyConfigureCtrl', 
    ($scope, $stateParams, $location, Survey) ->


      $scope.init = ->
        @SurveyService = new Survey(serverErrorHandler)
        $scope.survey = @SurveyService.find $stateParams.id
        $scope.siteUrl = $location.protocol() + '://' + $location.host() + '/'
        $scope.btnLabel = 'Save Survey'


      $scope.saveSurvey = (params) ->
        @SurveyService.update($scope.survey, params).then ->
          $location.url "/surveys"


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")