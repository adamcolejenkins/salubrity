@salubrity
  
  .config ($stateProvider) ->

    $stateProvider.state 'team',
      url: '/users'
      controller: 'UsersCtrl'

  .controller 'UsersCtrl', ($scope, $modal) ->
    
