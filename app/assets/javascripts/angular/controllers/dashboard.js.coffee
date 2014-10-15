@salubrity

  .config ($stateProvider) ->

    $stateProvider.state 'dashboard',
      url: '/dashboard'
      templateUrl: '/templates/dashboard.html'
      controller: 'DashboardCtrl'
  
  .controller "DashboardCtrl", ($scope, $stateParams, $location, Survey) ->

    