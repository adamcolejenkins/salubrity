@salubrity

  .controller 'ClinicCreateCtrl',
    ($scope, Clinic, Survey, $location, $modalInstance) ->

      $scope.init = ->
        @ClinicService = new Clinic(serverErrorHandler)
        @SurveyService = new Survey(serverErrorHandler)
        $scope.surveys = @SurveyService.all()

      $scope.proceed = (clinic) ->
        @ClinicService.create clinic, (clinic) ->
          $modalInstance.close()
          $location.url "/clinics/#{clinic.id}/configure"

      $scope.close = -> $modalInstance.dismiss "close"

      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )