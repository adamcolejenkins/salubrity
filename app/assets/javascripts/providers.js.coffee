@salubrity
  
  .controller 'ProviderListCtrl', ($scope, ProviderService, $modal) ->

    $scope.init = ->
      @ProviderService = new ProviderService(serverErrorHandler)
      $scope.providers = @ProviderService.all()


    serverErrorHandler = ->
      swal(
        title: 'Error!'
        text: "There was a server error, please reload the page and try again."
        type: 'error'
        confirmButtonText: 'Ok'
      )