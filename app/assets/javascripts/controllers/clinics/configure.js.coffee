@salubrity
  
  .config ($stateProvider) ->

    $stateProvider.state 'clinics.configure',
      url: '/:id/configure'
      controller: 'ClinicConfigureCtrl'
      templateUrl: '/templates/clinics/configure.html'


  .controller 'ClinicConfigureCtrl',
    ($scope, $stateParams, Clinic, Provider, $modal, $location) ->

      $scope.predicate = 'name'

      $scope.init = ->
        @ClinicService = new Clinic(serverErrorHandler)
        @ProviderService = new Provider($stateParams.id, serverErrorHandler)
        $scope.clinic = @ClinicService.find $stateParams.id


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


      $scope.previewSurvey = (clinic) ->

        @modal = $modal.open
          templateUrl: '/templates/partials/iframe.html'
          windowTemplateUrl: '/templates/partials/fullWidthModalWindow.html'
          controller: 'ClinicPreviewCtrl'
          resolve:
            clinic: -> clinic


      $scope.editClinic = (clinic) ->

        @modal = $modal.open
          templateUrl: '/templates/clinics/edit.html'
          windowTemplateUrl: '/templates/partials/modalFormWindow.html'
          controller: 'ClinicEditCtrl'
          resolve:
            clinic: -> clinic


      $scope.deleteClinic = (clinic) ->

        ClinicService = @ClinicService

        swal(
          title: 'Are you sure?'
          text: "You will not be able to recover #{clinic.title}.\n All providers and survey responses for this clinic will be permanently deleted."
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          , ->
            # Delete clinic via the API
            ClinicService.delete(clinic)
            # Remove clinic from the list
            $scope.$parent.clinics.splice $scope.$parent.clinics.indexOf(clinic), 1
            # Redirect to clinic list
            $location.path('/clinics')
        )


      serverErrorHandler = ->
        swal(
          title: 'Error!'
          text: "There was a server error, please reload the page and try again."
          type: 'error'
          confirmButtonText: 'Ok'
        )