@salubrity

  .config ($routeProvider) ->

    $routeProvider.when '/surveys',
      templateUrl: '/templates/surveys/list.html'
      controller: 'SurveyListCtrl'
  
  .controller "SurveyListCtrl", ($scope, $rootScope, $routeParams, $location, Survey) ->

    $scope.init = ->
      @SurveysService = new Survey(serverErrorHandler)
      $scope.surveys = @SurveysService.all()


    $scope.build = (survey) -> $location.path("/survey/#{survey.id}/build")

    $scope.create = -> $location.path("/survey/create")


    $scope.deleteSurvey = (survey) ->
      

    serverErrorHandler = ->
      alert("There was a server error, please reload the page and try again.")