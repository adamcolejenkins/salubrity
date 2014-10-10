@salubrity

  .controller 'ClinicCreateCtrl',
    ($scope, ClinicService, SurveyService, $state, $modalInstance) ->

      # Init scope
      $scope.init = ->
        @ClinicService = new ClinicService(serverErrorHandler)
        @SurveyService = new SurveyService(serverErrorHandler)
        $scope.surveys = @SurveyService.all()

      # Click Handler for the proceed button
      $scope.proceed = (clinic) ->
        # Use the ClinicService to connect to the API
        # to create the clinic
        @ClinicService.create clinic, (clinic) ->
          # On success, close the modal instance
          $modalInstance.close()
          # and redirect to the configure settings state
          $state.go "clinics.configure.settings", id: clinic.id

      # Click handler for the close button(s)
      $scope.close = ->
        # Dismiss (close) the modalInstance
        $modalInstance.dismiss "close"

      # Default server error handler
      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )