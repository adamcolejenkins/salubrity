@salubrity
  
  .controller 'ReportsCtrl', ($scope, SurveyService, ClinicService, ProviderService, $interval, $document) ->

    # Cache variable for storing data
    $scope.cache = []
    # How often we want to refresh
    $scope.refreshRate = 60000 # 60 seconds

    $scope.emptyData = 
      labels: []
      datasets: [
        {}
      ]

    # Set our resource on init
    $scope.init = (resourceName) ->
      return
      # Set our scope's resource name
      $scope.currentResourceName = resourceName

      # Start the action!
      queryResource()
      
      # TODO: Set an interval to update data
      $interval(tick, $scope.refreshRate)


    $scope.setRefreshRate = (rate) ->
      $scope.refreshRate = rate * 1000


    ###*
     * queryResource function
     * Set our current resource scope, pull data and set the fields
     * 
     * @param {string} resourceName The type of resource
    ###
    queryResource = ->
      
      # Instantiate our resource
      ResourceService = getResourceService $scope.currentResourceName
      
      # Query the resource and set fieldData
      ResourceService.all(setFieldData)
      
        
    ###*
     * Formats the field data for our charts
     * @param {object} resources list of resource data
    ###
    setFieldData = (resources) ->

      # Blank container
      obj = {}
    
      # Loop through our resources data
      angular.forEach resources, (resource, key) ->
    
        # Loop through our resource fields
        angular.forEach resource.fields, (field, id) ->

          # Set our fieldData to scope as fieldData_[resource.id]_[field.id]
          $scope["fieldData_#{resource.id}_#{field.id}"] =
            data: field.data
      
      console.log $scope

    ###*
     * Dynamically instantiate scoped resource and return it
     * @param  {string} resourceName The name of the resource (survey|clinic|provider)
     * @return {resource}            The resource object
    ###
    getResourceService = (resourceName) ->
      switch resourceName
        when "survey"
          new SurveyService(serverErrorHandler)
        when "clinic"
          new ClinicService(serverErrorHandler)
        when "provider"
          new ProviderService(serverErrorHandler)


    tick = ->
      console.log "Updating #{$scope.currentResourceName}s..."
      queryResource()
      

    serverErrorHandler = ->
      alert("There was a server error, please reload the page and try again.")