@salubrity #app

.controller "FieldSettingsCtrl",
  ($scope, $pageslideInstance, data, FieldService, FieldChoice, CONFIG) ->

    @field = data

    $scope.fieldChoice = new FieldChoice(@field.survey_id, @field.id, serverErrorHandler)

    # Bind field to scope
    $scope.field = @field

    # Build select options
    $scope.contexts = []
    angular.forEach CONFIG.fieldContexts, (obj) ->
      $scope.contexts[obj.context] = obj.label

    $scope.layouts = []
    angular.forEach
      oneColumn: "One Column"
      twoColumns: "Two Columns"
      sideBySide: "Side by Side"
    , (value, key) ->
      $scope.layouts[key] = value

    $scope.sizes = []
    angular.forEach
      small: "Small"
      medium: "Medium"
      large: "Large"
    , (value, key) ->
      $scope.sizes[key] = value

    $scope.displays = []
    angular.forEach
      standard: "Standard"
      buttons: "Buttons"
    , (value, key) ->
      $scope.displays[key] = value


    # Determine whether a field property is in use
    $scope.property = (property) ->
      $scope.field.properties and $scope.field.properties.settings.indexOf(property) isnt -1


    # Add a choice to choices
    $scope.addChoice = (index) ->
      $scope.fieldChoice.create(label: 'Another Choice', key: 'another_choice').then (choice) ->
        $scope.field.field_choices.push choice


    $scope.updateChoice = (choice, index) ->
      $scope.fieldChoice.update(choice, choice)


    # Remove a choice from choices
    $scope.deleteChoice = (choice, index) ->
      $scope.fieldChoice.delete(choice).then ->
        $scope.field.field_choices.splice index, 1


    # Save the field and close the pageslide window
    $scope.saveFieldSettings = (field) ->

      # Instantiate a new Field service resource
      new FieldService(field.survey_id, serverErrorHandler)

        # Update the field in the db
        .update(field, field).then (field) ->

          # Close pageslide
          $pageslideInstance.close(field)


    $scope.close = -> $pageslideInstance.dismiss "close"

    serverErrorHandler = ->
      alert("There was a server error, please reload the page and try again.")
