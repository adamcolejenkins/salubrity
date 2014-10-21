@salubrity
  
  .config ($stateProvider) ->

    $stateProvider.state 'kiosk.show',
      url: '/:guid'
      controller: 'KioskShowCtrl'

  .controller 'KioskShowCtrl', ($scope) ->

