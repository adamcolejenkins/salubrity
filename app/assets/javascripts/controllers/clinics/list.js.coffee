@salubrity

  .config ($stateProvider) ->

    $stateProvider.state 'clinics',
      url: '/clinics'
      controller: 'ClinicListCtrl'
      templateUrl: '/templates/clinics/index.html'


  .controller 'ClinicListCtrl',
    ($scope, Clinic, $modal) ->

      $scope.init = ->
        @ClinicService = new Clinic(serverErrorHandler)
        $scope.clinics = @ClinicService.all()


      $scope.create = ->
        ClinicService = @ClinicService

        # Display a modal form
        @modal = $modal.open
          templateUrl: '/templates/clinics/new.html',
          windowTemplateUrl: '/templates/partials/modalFormWindow.html'
          controller: 'ClinicCreateCtrl'



      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )