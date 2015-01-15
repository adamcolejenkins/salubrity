@salubrity
  
  .factory 'FieldService', ($resource, $http) ->

    class FieldService
      constructor: (surveyId, errorHandler) ->
        @service = $resource('/config/surveys/:survey_id/fields/:id.json',
          {survey_id: surveyId, id: '@id'},
          {update: {method: 'PATCH'}, save: {method: 'PATCH'}})
        @errorHandler = errorHandler

        # Fix needed for the PATCH method to use application/json content type
        defaults = $http.defaults.headers
        defaults.patch = defaults.patch || {}
        defaults.patch['Content-Type'] = 'application/json'

      create: (attrs, successHandler) ->
        new @service(field: attrs).$save ((field) -> attrs.id = field.id), @errorHandler

      delete: (field) ->
        new @service().$delete {id: field.id}, (-> null), @errorHandler

      update: (field, attrs) ->
        new @service(field: attrs).$update {id: field.id}, (-> null), @errorHandler

      all: (callback) ->
        @service.query(callback || (-> null), @errorHandler)

      find: (id, successHandler) ->
        @service.get(id: id, ((field)->
          successHandler?(field)
          field),
        @errorHandler)