@salubrity
  
  .controller 'ClinicListCtrl', ($scope, ClinicService, $modal) ->

    $scope.init = ->
      @ClinicService = new ClinicService(serverErrorHandler)
      $scope.clinics = @ClinicService.all()


    serverErrorHandler = ->
      swal(
        title: 'Error!'
        text: "There was a server error, please reload the page and try again."
        type: 'error'
        confirmButtonText: 'Ok'
      )