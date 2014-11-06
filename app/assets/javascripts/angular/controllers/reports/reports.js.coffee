@salubrity
  
  .controller 'ReportsCtrl', ($scope, SurveyService, ClinicService, ProviderService, $interval, $document) ->

    $scope.cache = []
    $scope.refreshRate = 10000
    $scope.field = []

    $scope.init = (resourceName) ->
      console.log resourceName
      setResource resourceName
      # $interval(tick, $scope.refreshRate) # Future addtion


    $scope.setField = (resourceId, fieldId) ->
      console.log resourceId, fieldId
      console.log $scope.resources
      angular.forEach $scope.resources, (resource, id) ->
        console.log resource
        if resource.id is resourceId
          angular.forEach resource.fields, (field, id) ->
            return field.answers if field.id is fieldId


    setResource = (resourceName) ->
      $scope.currentResourceName = resourceName

      unless $scope.cache[resourceName]?
        ResourceService = getResourceService(resourceName)
        $scope.cache[resourceName] =
          resource: ResourceService
          data: ResourceService.all()

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