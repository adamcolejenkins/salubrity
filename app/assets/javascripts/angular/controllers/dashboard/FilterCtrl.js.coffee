@salubrity

  .controller 'DashboardFilterCtrl', ($scope, SurveyService, ClinicService, ProviderService, $window) ->

    $scope.URI = new Uri($window.location.href)

    $scope.init = (params) ->

      @SurveyService = new SurveyService(serverErrorHandler)
      @ClinicService = new ClinicService(serverErrorHandler)
      @ProviderService = new ProviderService(serverErrorHandler)

      @SurveyService.all (surveys) ->
        $scope.surveys = surveys
        $scope.survey =
          selected: select(params.survey, $scope.surveys)

      @ClinicService.all (clinics) ->
        $scope.clinics = clinics
        $scope.clinic =
          selected: select(params.clinic, $scope.clinics)

      @ProviderService.all (providers) ->
        $scope.providers = providers
        $scope.provider = 
          selected: select(params.provider, $scope.providers)


    $scope.clear = ->
      # Unset Clinic & Provider params
      setParam 'clinic'
      setParam 'provider'

      # Unset selected scopes
      $scope.clinic.selected = undefined
      $scope.provider.selected = undefined

      # GO
      go()

    $scope.setSurvey = ($item) ->
      console.log 'setSurvey', $item

      # Unset Clinic & Provider params
      setParam 'clinic'
      setParam 'provider'

      # Set Survey param
      setParam 'survey', $item.id

      # GO
      go()


    $scope.setClinic = ($item) ->
      console.log 'setClinic', $item

      # Unset Provider param
      setParam 'provider'

      # Set Clinic param
      setParam 'clinic', $item.id

      # GO
      go()


    $scope.setProvider = ($item) ->
      console.log 'setProvider', $item

      # Set Provider param
      setParam 'provider', $item.id

      # GO
      go()


    setParam = (key, val) ->
      unless val?
        $scope.URI.deleteQueryParam key
      else
        $scope.URI.replaceQueryParam key, val


    go = ->
      $window.location.href = $scope.URI


    select = (id, resources) ->
      # We need an ID
      return  unless id?

      # Search for individual resource
      result = $.grep(resources, (e) ->
        e.id is parseInt(id)
      )

      # Return if not found
      if result.length is 0
        return

      # Return the found resource or the first one
      else
        result[0]


    serverErrorHandler = ->
      alert("There was a server error, please reload the page and try again.")