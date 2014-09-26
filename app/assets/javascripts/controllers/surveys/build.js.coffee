@salubrity
  
  .config ($routeProvider) ->

  
    $routeProvider.when '/survey/:id/build',
      templateUrl: '/templates/surveys/build.html'
      controller: 'SurveyBuildCtrl'


  .controller 'SurveyBuildCtrl', 
    ($scope, $rootScope, $routeParams, $timeout, $filter, $modal, $pageslide, Survey, Field) ->

      $scope.sortMethod = 'priority'
      $scope.sortableEnabled = true

      $scope.init = ->
        @FieldService = new Field($routeParams.id, serverErrorHandler)
        @SurveyService = new Survey(serverErrorHandler)
        $scope.survey = @SurveyService.find $routeParams.id
        $scope.survey.fields = bindProperties $scope.survey.fields


      $scope.addField = () ->
        @modal = $modal.open
          templateUrl: '/templates/fields/add.html'
          windowTemplateUrl: '/templates/partials/modalWindow.html'
          controller: 'FieldAddCtrl'
          windowClass: 'md-show'
          resolve:
            data: -> $scope.survey

        @modal.result.then (field) ->
          $scope.survey.fields.push bindProperties(field)


      $scope.editField = (field, $event) ->
        
        angular.element($event.currentTarget).addClass 'editing'

        FieldService = @FieldService

        @pageslide = $pageslide.open
          templateUrl: '/templates/fields/settings.html'
          controller: 'FieldSettingsCtrl'
          resolve:
            data: -> field

        @pageslide.result.then ->
          angular.element($event.currentTarget).removeClass 'editing'
        

      $scope.deleteField = (field, index) ->

        FieldService = @FieldService

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
          
          domIndexOf = (e) -> e.siblings().andSelf().index(e)
          newPriority = domIndexOf(ui.item)

          field = ui.item.scope().field
          field.priority = newPriority
          $scope.priorityChanged(field)


      serverErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")


      bindProperties = (field) ->
        if angular.isArray field
          angular.forEach field, (value, key) ->
            value.properties = $filter('fieldTypeSearch')('type', value.field_type)
        else
          field.properties = $filter('fieldTypeSearch')('type', field.field_type) if field

        field


      setFields = (fields) -> 
        $scope.survey.fields = bindProperties(fields)


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