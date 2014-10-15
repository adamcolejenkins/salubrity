@salubrity

  .controller 'ProviderCreateCtrl',
    ($scope, Provider, $stateParams, $modalInstance) ->

      $scope.s3OptionsUri = '/api/s3/token'

      $scope.init = ->
        @ProviderService = new Provider($stateParams.id, serverErrorHandler)


      $scope.proceed = (provider) ->
        @ProviderService.create(provider).then (provider) -> $modalInstance.close(provider)
          

      $scope.close = -> $modalInstance.dismiss "close"


      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )