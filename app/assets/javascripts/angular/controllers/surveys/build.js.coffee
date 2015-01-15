@salubrity

  .controller 'SurveyBuildCtrl', 
    ($scope, $rootScope, $timeout, $modal, $document, SurveyService, FieldService, FieldChoice, $location, CONFIG) ->

      $scope.sortMethod = 'priority'
      $scope.sortableEnabled = true
      $scope.activeField = null
      $scope.editMode = false

      $scope.init = (surveyId) ->
        # Set up Survey
        @SurveyService = new SurveyService(serverErrorHandler)
        $scope.survey = @SurveyService.find surveyId

        # Set up Fields
        @FieldService = new FieldService(surveyId, serverErrorHandler)
        @FieldService.all (fields) ->
          $scope.fields = fields

          # $scope.$watch 'fields', (newValue, oldValue) ->
          #   if (newValue and newValue isnt oldValue)
          #     $scope.loading = true
          #     $scope.fields.$save()


      # NEW
      $scope.startEditMode = (field) ->
        $scope.activeField = field
        $scope.editMode = true


      $scope.endEditMode = ->
        console.log 'End edit mode'
        $scope.activeField = null
        $scope.editMode = false


      $scope.isActive = (id) ->
        $scope.activeField isnt null and $scope.activeField.id is id


      # NEW
      $scope.updateField = (id, $data) ->
        console.log id, $data


      $scope.addField = (field) ->

        # Set default field data
        fieldData = angular.extend(
          context: field.context
          label: 'Untitled ' + field.label
        , field.defaults)

        @FieldService.create(fieldData).then (field) ->

          # Display Field Settings window
          $scope.editField(field)
          $scope.fields.push(field)


      $scope.deleteField = (field, index) ->

        FieldService = @FieldService

        swal(
          title: 'Are you sure?'
          text: "You will not be able to recover this field and its results."
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          , ->
            # Lower priorities of fields
            lowerPrioritiesBelow field
            # Delete field via the API
            FieldService.delete field
            # Remove clinic from the list
            $scope.fields.splice($scope.fields.indexOf(field), 1)
        )
            

      $scope.priorityChanged = (field) ->
        @FieldService.update(field, target_priority: field.priority)
        updatePriorities()


      $scope.sortableOptions = 
        # axis: 'y'
        opacity: 0.7
        placeholder: 'sort-placeholder'
        sort: (e, ui) ->
          ui.placeholder.height ui.item.height()

        update: (e, ui) ->
          # TODO: Don't let item priority be last
          if ui.item.scope().field.properties.noSort is true
            ui.item.sortable.cancel()

          domIndexOf = (e) -> e.siblings().andSelf().index(e)
          newPriority = domIndexOf(ui.item)

          field = ui.item.scope().field
          field.priority = newPriority
          $scope.priorityChanged(field)


      updatePriorities = ->
        # During rendering it's simplest to just mirror priorities based
        # on field positiions in the list
        $timeout ->
          angular.forEach $scope.fields, (field, index) ->
            field.priority = index + 1


      raisePriorities = ->
        angular.forEach $scope.fields, (f) -> f.priority += 1


      lowerPrioritiesBelow = (field) ->
        angular.forEach fieldsBelow(field), (f) -> 
          f.priority -= 1


      fieldsBelow = (field) ->
        $scope.fields.slice($scope.fields.indexOf(field), $scope.fields.length)


      updateSurvey = (params) ->
        angular.extend($scope.survey, params)
        @SurveyService.update($scope.survey, params)


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")

      # $document.find('main, .form-preview').click () ->
      #   console.log 'main clicked'
      #   $scope.endEditMode()