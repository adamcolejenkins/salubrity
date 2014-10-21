@salubrity
  
  .config ($stateProvider) ->

    $stateProvider.state 'clinics.configure.providers',
      url: '/providers'
      controller: 'ClinicConfigureProvidersCtrl'
      templateUrl: '/templates/providers/list.html'


  .controller 'ClinicConfigureProvidersCtrl',
    ($scope, Clinic, Provider, $modal) ->

      console.log $scope

      $scope.addProvider = ->

        @modal = $modal.open
          templateUrl: '/templates/providers/new.html',
          windowTemplateUrl: '/templates/partials/modalFormWindow.html'
          controller: 'ProviderCreateCtrl'

        @modal.result.then (provider) -> $scope.clinic.providers.push provider


      $scope.editProvider = (provider) ->

        @modal = $modal.open
          templateUrl: '/templates/providers/edit.html',
          windowTemplateUrl: '/templates/partials/modalFormWindow.html'
          controller: 'ProviderEditCtrl'
          resolve:
            provider: -> provider


      $scope.deleteProvider = (provider) ->

        ProviderService = @ProviderService

        swal(
          title: 'Are you sure?'
          text: "You will not be able to recover #{provider.name}\n or their responses."
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          , ->
            ProviderService.delete(provider)
            $scope.clinic.providers.splice $scope.clinic.providers.indexOf(provider), 1
        )