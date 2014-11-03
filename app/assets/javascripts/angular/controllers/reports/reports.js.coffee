@salubrity
  
  .controller 'ReportsCtrl', ($scope, SurveyService, ClinicService, ProviderService, $interval) ->

    $scope.cache = []
    $scope.refreshRate = 10000

    $scope.init = ->
      $scope.setResource 'provider'
      # $interval(tick, $scope.refreshRate) # Future addtion

    
    $scope.setResource = (resourceName) ->
      $scope.currentResourceName = resourceName

      unless $scope.cache[resourceName]?
        ResourceService = getResourceService(resourceName)
        $scope.cache[resourceName] =
          resource: ResourceService
          data: ResourceService.all()

      console.log $scope.cache[resourceName]

      $scope.resources = $scope.cache[resourceName].data

    
    getResourceService = (resourceName) ->
      @SurveyService = new SurveyService(serverErrorHandler)
      @ClinicService = new ClinicService(serverErrorHandler)
      @ProviderService = new ProviderService(serverErrorHandler)

      switch resourceName
        when "survey"
          @SurveyService
        when "clinic"
          @ClinicService
        when "provider"
          @ProviderService


    tick = ->
      console.log "Updating..."
      $scope.resources = $scope.cache[$scope.currentResourceName].data[$scope.cache[$scope.currentResourceName].resource.all()]


    serverErrorHandler = ->
      alert("There was a server error, please reload the page and try again.")