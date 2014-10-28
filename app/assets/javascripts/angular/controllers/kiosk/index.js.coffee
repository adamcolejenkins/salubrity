@salubrity
  
  # .config ($stateProvider) ->

  #   $stateProvider.state 'kiosk',
  #     url: '/kiosk'
  #     controller: 'KioskCtrl'


  .controller 'KioskCtrl', ($scope, $location, ipCookie, ClinicService) ->
    
    $scope.clinic = null
    $scope.survey = null

    $scope.set = 
      clinic: null
      survey: null

    $scope.init =->

      @ClinicService = new ClinicService(serverErrorHandler)
      $scope.clinics = @ClinicService.all()

      # Check if we have clinic & survey stored
      $scope.clinic = ipCookie '_salubrity_kiosk_clinic'
      $scope.survey = ipCookie '_salubrity_kiosk_survey'
      $scope.cookie = (if $scope.clinic and $scope.survey then true else false)


    $scope.setClinic = (clinic) ->
      $scope.clinic = clinic
      $scope.surveys = [clinic.survey] # Change to clinic.surveys when it's set up

    $scope.setSurvey = (survey) ->
      $scope.survey = survey


    $scope.proceed = (env) ->
      # Set cookies if public for easy return to survey
      if env == 'public'
        ipCookie '_salubrity_kiosk_clinic', $scope.set.clinic, expires: 30
        ipCookie '_salubrity_kiosk_survey', $scope.set.survey, expires: 30
      else if env == 'admin'
        ipCookie.remove '_salubrity_kiosk_clinic'
        ipCookie.remove '_salubrity_kiosk_survey'

      

      # $location.url "/kiosk/#{clinic}/#{survey}"


    # Default server error handler
    serverErrorHandler = ->
      swal(
        title: 'Error!'
        text: "There was a server error, please reload the page and try again."
        type: 'error'
        confirmButtonText: 'Ok'
      )