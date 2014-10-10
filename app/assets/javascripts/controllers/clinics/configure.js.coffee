@salubrity
  
  .config ($stateProvider) ->

    # This is an abstract state for retrieving the clinic
    # from the API and setting the scope for all child states
    $stateProvider.state 'clinics.configure',
      abstract: true
      url: '/{id:[0-9]{1,8}}'
      controller: 'ClinicConfigureCtrl'
      templateUrl: '/templates/clinics/configure.html'
      resolve:
        Clinic: (ClinicService, $stateParams) -> new ClinicService().find $stateParams.id


  .controller 'ClinicConfigureCtrl',
    ($scope, $stateParams, $modal, $state, Clinic) ->

      # Init scope
      $scope.init = ->
        $scope.predicate = 'name'
        $scope.clinic = Clinic

      # Click handler for the preview button
      $scope.previewSurvey = ->

        # Display a modal
        @modal = $modal.open
          templateUrl: '/templates/partials/iframe.html'
          windowTemplateUrl: '/templates/partials/fullWidthModalWindow.html'
          controller: 'ClinicPreviewCtrl'
          resolve:
            clinic: -> $scope.clinic

      # Click handler for the delete button
      $scope.deleteClinic = (clinic) ->

        # Display a Sweet Alert modal
        swal(
          title: 'Are you sure?'
          text: "You will not be able to recover #{clinic.title}.\n All providers and survey responses for this clinic will be permanently deleted."
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          , ->
            # Delete clinic via the API
            $scope.clinic.delete(clinic)
            # Remove clinic from the list
            $scope.$parent.clinics.splice $scope.$parent.clinics.indexOf(clinic), 1
            # Redirect to clinic list
            $state.go('clinics')
        )

      # Default server error handler
      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )