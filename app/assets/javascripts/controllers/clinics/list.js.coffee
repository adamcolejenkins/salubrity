@salubrity

  .config ($stateProvider) ->

    # Let Angular know about our state
    $stateProvider.state 'clinics',
      url: '/clinics'
      controller: 'ClinicListCtrl'
      templateUrl: '/templates/clinics/index.html'
      resolve:
        Clinics: (ClinicService) -> new ClinicService().all()


  .controller 'ClinicListCtrl',
    ($scope, Clinics, ClinicService, $modal) ->

      # Initialize Scope
      $scope.init = ->
        $scope.clinics = Clinics

      # Create button click handler
      $scope.create = ->

        # Display a modal form
        @modal = $modal.open
          templateUrl: '/templates/clinics/new.html',
          windowTemplateUrl: '/templates/partials/modalFormWindow.html'
          controller: 'ClinicCreateCtrl'



        