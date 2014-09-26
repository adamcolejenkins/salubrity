@salubrity #app

  .controller "FieldAddCtrl", 
    ($scope, $rootScope, Field, FieldChoice, CONFIG) ->

      @field = null

      $scope.init = ->
        @FieldService = new Field($rootScope.id, serverErrorHandler)

      # Set the scope for the templates
      $scope.fieldTypes = CONFIG.fieldTypes

      # Button handler for adding a field
      $scope.add = (field) ->

        # Create a store object with defaults
        fieldData = angular.extend(
          field_type: field.type
          label: "Untitled " + field.label
        , field.defaults)

        # Store the field with dummy content
        @FieldService.create(fieldData).then (field) ->
          angular.forEach fieldData.field_choices, (choice, index) ->
            new FieldChoice(data.id, field.id, serverErrorHandler).create(choice)


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")

