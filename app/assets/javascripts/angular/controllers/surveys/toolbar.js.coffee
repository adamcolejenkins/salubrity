@salubrity
  
  .controller 'SurveyToolbarCtrl', ($scope, CONFIG) ->

    $scope.fieldContexts = CONFIG.fieldContexts


    $scope.isToggleActive = (tool, inState) ->
      fieldSelected() and $scope.activeField[tool] is inState


    $scope.toolDisabled = (property) ->
      !$scope.editMode or !usesProperty property


    $scope.display = (label) ->
      $scope.displayText = label or $scope.survey.title


    fieldSelected = ->
      $scope.activeField isnt null


    usesProperty = (property) ->
      fieldSelected() and $scope.activeField.properties.settings.indexOf(property) isnt -1