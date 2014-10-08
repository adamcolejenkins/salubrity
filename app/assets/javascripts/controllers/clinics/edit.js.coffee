@salubrity

  .controller 'ClinicEditCtrl',
    ($scope, Clinic, $modalInstance, clinic) ->

      $scope.init = ->
        $scope.clinic = clinic

      $scope.proceed = (clinic) ->
        $scope.clinic.update(clinic, clinic).then (clinic) -> $modalInstance.close(clinic)

      $scope.close = -> $modalInstance.dismiss "close"

      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )