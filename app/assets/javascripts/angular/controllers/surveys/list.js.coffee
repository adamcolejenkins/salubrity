@salubrity

  # .config ($stateProvider) ->

  #   $stateProvider.state 'surveys',
  #     url: '/surveys'
  #     controller: 'SurveyListCtrl'
  #     templateUrl: '/templates/surveys/list.html'
  

  .controller "SurveyListCtrl", ($scope, $rootScope, SurveyService, $modal) ->

    $scope.init = ->
      @SurveyService = new SurveyService(serverErrorHandler)

    $scope.publish = (id, evt, published) ->
      return if published?

      @SurveyService.update id: id,
        status: 'published'

      angular.element(evt.currentTarget).addClass("published").removeClass("draft")
      swal "Published!", "This survey is now live.", "success"

    serverErrorHandler = ->
      swal(
        title: 'Error!'
        text: "There was a server error, please reload the page and try again."
        type: 'error'
        confirmButtonText: 'Ok'
      )