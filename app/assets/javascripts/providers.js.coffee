@salubrity
  
  .controller 'ProviderListCtrl', ($scope, ProviderService, $modal, $http) ->

    $scope.merge = 
      provider:
        selected: null
      with:
        selected: null

    $scope.init = ->
      @ProviderService = new ProviderService(serverErrorHandler)
      $scope.providers = @ProviderService.all()


    defaultErrorHandler = (msg) ->
      swal(
        title: 'Oops!'
        text: msg
        type: "error"
        confirmButtonText: 'Ok'
      )