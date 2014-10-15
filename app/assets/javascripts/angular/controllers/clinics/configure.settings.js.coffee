@salubrity
  
  .config ($stateProvider) ->

    $stateProvider.state 'clinics.configure.settings',
      url: '/settings'
      controller: 'ClinicConfigureSettingsCtrl'
      templateUrl: '/templates/clinics/settings.html'


  .controller 'ClinicConfigureSettingsCtrl',
    ($scope, Clinic, Provider, $modal) ->

      $scope.save = (clinic) ->
        $scope.clinic.update(clinic, clinic).then (clinic) -> $modalInstance.close(clinic)