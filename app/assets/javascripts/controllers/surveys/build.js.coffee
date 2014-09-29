@salubrity
  
  .config ($routeProvider) ->

  
    $routeProvider.when '/survey/:id/build',
      templateUrl: '/templates/surveys/build.html'
      controller: 'SurveyBuildCtrl'


  .controller 'SurveyBuildCtrl', 
    ($scope, $rootScope, $routeParams, $timeout, $modal, $pageslide, Survey, Field, FieldChoice) ->

      $scope.sortMethod = 'priority'
      $scope.sortableEnabled = true

      $scope.init = ->
        $scope.FieldService = new Field($routeParams.id, serverErrorHandler)
        $scope.SurveyService = new Survey(serverErrorHandler)
        $scope.survey = $scope.SurveyService.find $routeParams.id
        # $scope.fields = $scope.FieldService.all()
        # $timeout(->
        #   $scope.survey.intro = $scope.FieldService.find($scope.survey.intro_id) if $scope.survey.intro_id
        #   $scope.survey.outro = $scope.FieldService.find($scope.survey.outro_id) if $scope.survey.outro_id
        # 500)


      $scope.addField = (field) ->

        # Set default field data
        fieldData = angular.extend(
          field_type: field.type
          label: 'Untitled ' + field.label
        , field.defaults)

        $scope.FieldService.create(fieldData).then (field) ->

          # Loop through default field choices and add them
          # TODO: This could be done server-side
          # angular.forEach fieldData.field_choices, (choice, index) ->
          #   new FieldChoice($scope.survey.id, field.id, serverErrorHandler).create(choice)

          # Display Field Settings window
          $scope.editField(field)

          # Set survey intro ID and scope if Intro field
          if field.field_type == 'intro'
            field.priority = 1
            $scope.priorityChanged(field)
            updateSurvey(intro_id: field.id)
            $scope.survey.fields.unshift field

          # Set survey outro ID and scope if Outro field
          else if field.field_type == 'outro'
            updateSurvey(outro_id: field.id)
            $scope.survey.fields.push field

          # Otherwise add field to field list
          else
            if $scope.survey.outro_id
              field.priority = $scope.survey.fields.length - 1
              $scope.priorityChanged(field)
              $scope.survey.fields.splice $scope.survey.fields.length - 1, 0, field
            else
              console.log "outro_id: FALSE"
              $scope.survey.fields.push(field)


      $scope.editField = (field, $event) ->
        FieldService = $scope.FieldService

        @pageslide = $pageslide.open
          templateUrl: '/templates/fields/settings.html'
          controller: 'FieldSettingsCtrl'
          resolve:
            data: -> field
        

      $scope.deleteField = (field, index) ->

        FieldService = $scope.FieldService

        # Display a modal confirmation window
        @modal = $modal.open
          templateUrl: '/templates/fields/delete.html'
          windowTemplateUrl: '/templates/partials/modalWindow.html'
          controller: 'FieldDeleteCtrl'
          windowClass: 'md-show danger'
          resolve:
            data: -> field

        # Proceed to delete
        @modal.result.then (field) ->
          lowerPrioritiesBelow(field)
          FieldService.delete(field)
          $scope.survey.fields.splice($scope.survey.fields.indexOf(field), 1)

          if field.field_type == 'intro'
            updateSurvey(intro_id: null)
          else if field.field_type == 'outro'
            updateSurvey(outro_id: null)


      $scope.priorityChanged = (field) ->
        $scope.FieldService.update(field, target_priority: field.priority)
        updatePriorities()


      $scope.sortableOptions = 
        axis: 'y'
        opacity: 0.7
        placeholder: 'sort-placeholder'
        sort: (e, ui) ->
          ui.placeholder.height ui.item.height()

        update: (e, ui) ->
          # TODO: Don't let item priority be last
          if ui.item.scope().field.properties.noSort == true
            ui.item.sortable.cancel()

          domIndexOf = (e) -> e.siblings().andSelf().index(e)
          newPriority = domIndexOf(ui.item)

          field = ui.item.scope().field
          field.priority = newPriority
          $scope.priorityChanged(field)


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")


      updatePriorities = ->
        # During rendering it's simplest to just mirror priorities based
        # on field positiions in the list
        $timeout ->
          angular.forEach $scope.survey.fields, (field, index) ->
            field.priority = index + 1


      raisePriorities = ->
        angular.forEach $scope.survey.fields, (f) -> f.priority += 1


      lowerPrioritiesBelow = (field) ->
        angular.forEach fieldsBelow(field), (f) -> 
          f.priority -= 1


      fieldsBelow = (field) ->
        $scope.survey.fields.slice($scope.survey.fields.indexOf(field), $scope.survey.fields.length)


      updateSurvey = (params) ->
        angular.extend($scope.survey, params)
        $scope.SurveyService.update($scope.survey, params)
        console.log params, $scope.survey