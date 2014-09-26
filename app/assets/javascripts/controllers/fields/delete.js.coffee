@salubrity #app

  .controller 'FieldDeleteCtrl', [
    '$scope',
    '$modalInstance',
    'data',
    ($scope, $modalInstance, data) ->

      $scope.field = data

      # Event handler to proceed
      $scope.proceed = -> $modalInstance.close($scope.field)

      # Handle the modal window cancel button event
      $scope.cancel = -> $modalInstance.dismiss 'cancel'

  ]