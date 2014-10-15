@salubrity
  
  .config ($stateProvider) ->

    $stateProvider.state 'clinics.configure.design',
      url: '/design'
      controller: 'ClinicConfigureDesignCtrl'
      templateUrl: '/templates/clinics/design.html'


  .controller 'ClinicConfigureDesignCtrl',
    ($scope, Clinic, Provider, $modal) ->

      $scope.orientation = 'landscape'