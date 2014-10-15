@salubrity

  .controller 'ClinicPreviewCtrl',
    ($scope, $modalInstance, $sce, clinic) ->

      $scope.init = ->
        $scope.url = $sce.trustAsResourceUrl('/picker-patient-experience')

      $scope.proceed = ->
        $modalInstance.close()

      $scope.close = ->
        $modalInstance.dismiss('close')