@salubrity
  
  .config ($stateProvider) ->
  
    $stateProvider.state 'surveys.build',
      url: '/:id/build'
      templateUrl: '/templates/surveys/build.html'
      controller: 'SurveyBuildCtrl'


  .controller 'SurveyBuildCtrl', 
    ($scope, $rootScope, $stateParams, $timeout, $modal, $pageslide, SurveyService, FieldService, FieldChoice, $location) ->

      $scope.sortMethod = 'priority'
      $scope.sortableEnabled = true

      $scope.init = ->
        @FieldService = new FieldService($stateParams.id, serverErrorHandler)
        @SurveyService = new SurveyService(serverErrorHandler)
        $scope.survey = @SurveyService.find $stateParams.id

      $scope.addField = (field) ->

        # Set default field data
        fieldData = angular.extend(
          field_type: field.type
          label: 'Untitled ' + field.label
        , field.defaults)

        @FieldService.create(fieldData).then (field) ->

          # Display Field Settings window
          $scope.editField(field)
          $scope.survey.fields.push(field)


      $scope.editField = (field, $event) ->
        FieldService = @FieldService

        @pageslide = $pageslide.open
          templateUrl: '/templates/fields/settings.html'
          controller: 'FieldSettingsCtrl'
          resolve:
            data: -> field
        

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
            $scope.survey.fields.splice($scope.survey.fields.indexOf(field), 1)
        )

      $scope.editSurvey = (survey) ->

        @modal = $modal.open
          templateUrl: '/templates/surveys/edit.html'
          windowTemplateUrl: '/templates/partials/modalFormWindow.html'
          controller: 'SurveyEditCtrl'
          resolve:
            survey: -> survey
            

      $scope.deleteSurvey = (survey) ->
        SurveyService = @SurveyService

        swal(
          title: 'Are you sure?'
          text: 'Deleting this survey will delete all results, including results tied to clinics and providers.'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          , ->
            $timeout(->
              swal(
                title: 'Are you absolutely sure?'
                text: 'This cannot be undone, what\'s done is done. There is absolutely no return.'
                type: 'warning'
                showCancelButton: true
                cancelButtonText: 'I\'m having second thoughts!'
                confirmButtonColor: '#DD6B55'
                confirmButtonText: 'Yes, I\'m absolutely sure, delete it!'
                , ->
                  SurveyService.delete($scope.survey).then ->
                    $timeout(->
                      swal(
                        title: 'Successfully deleted survey!'
                        text: 'I hope you didn\'t need that.'
                        confirmButtonColor: '#A5DC86'
                        type: 'success'
                      )
                      # Remove clinic from the list
                      $scope.$parent.surveys.splice $scope.$parent.surveys.indexOf(survey), 1
                      # Redirect to clinic list
                      $location.path('/surveys')
                    , 300)
              )
            , 300)
        )


      $scope.priorityChanged = (field) ->
        @FieldService.update(field, target_priority: field.priority)
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
        @SurveyService.update($scope.survey, params)


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")