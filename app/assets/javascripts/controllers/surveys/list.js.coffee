@salubrity

  .config ($stateProvider) ->

    $stateProvider.state 'surveys',
      url: '/surveys'
      controller: 'SurveyListCtrl'
      templateUrl: '/templates/surveys/list.html'
  

  .controller "SurveyListCtrl", ($scope, $rootScope, Survey, $modal) ->

    $scope.init = ->
      @SurveyService = new Survey(serverErrorHandler)
      $scope.surveys = @SurveyService.all()


    $scope.createSurvey = ->
      SurveyService = @SurveyService

      # Display a modal form
      @modal = $modal.open
        templateUrl: '/templates/surveys/new.html'
        windowTemplateUrl: '/templates/partials/modalFormWindow.html'
        controller: 'SurveyCreateCtrl'


    serverErrorHandler = ->
      swal(
        title: 'Error!'
        text: "There was a server error, please reload the page and try again."
        type: 'error'
        confirmButtonText: 'Ok'
      )