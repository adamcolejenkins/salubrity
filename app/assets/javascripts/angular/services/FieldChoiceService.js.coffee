@salubrity
  
  .factory 'FieldChoice', ($resource, $http) ->

    class FieldChoice
      constructor: (surveyId, fieldId, errorHandler) ->
        @service = $resource('/config/surveys/:survey_id/fields/:field_id/field_choices/:id',
          {survey_id: surveyId, field_id: fieldId, id: '@id'},
          {update: {method: 'PATCH'}})
        @errorHandler = errorHandler

        # Fix needed for the PATCH method to use application/json content type
        defaults = $http.defaults.headers
        defaults.patch = defaults.patch || {}
        defaults.patch['Content-Type'] = 'application/json'

      create: (attrs, successHandler) ->
        new @service(field_choice: attrs).$save ((field_choice) -> attrs.id = field_choice.id), @errorHandler

      delete: (field_choice) ->
        new @service().$delete {id: field_choice.id}, (-> null), @errorHandler

      update: (field_choice, attrs) ->
        new @service(field_choice: attrs).$update {id: field_choice.id}, (-> null), @errorHandler

      all: ->
        @service.query((-> null), @errorHandler)

      find: (id, successHandler) ->
        @service.get(id: id, ((field_choice)->
          successHandler?(field_choice)
          field_choice),
        @errorHandler)