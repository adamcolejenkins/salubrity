@salubrity

  .config ($routeProvider) ->

    $routeProvider.when '/dashboard',
      templateUrl: '/templates/dashboard.html'
      controller: 'DashboardCtrl'
  
  .controller "DashboardCtrl", ($scope, $routeParams, $location, Survey) ->

    