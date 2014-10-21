@salubrity

  .controller 'ProviderEditCtrl',
    ($scope, Provider, $stateParams, $modalInstance, provider) ->

      $scope.init = ->
        @ProviderService = new Provider($stateParams.id, provider.id, serverErrorHandler)
        $scope.provider = provider


      $scope.proceed = (provider) ->
        @ProviderService.update(provider, provider).then (provider) -> $modalInstance.close(provider)
          

      $scope.close = -> $modalInstance.dismiss "close"


      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )