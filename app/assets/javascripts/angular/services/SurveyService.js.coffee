@salubrity
  
  .factory 'SurveyService', ($resource, $http, $filter) ->

    class SurveyService
      constructor: (errorHandler) ->
        @service = $resource('/config/surveys/:id.json',
          {id: '@id'},
          {update: {method: 'PATCH'}, save: {method: 'PATCH'}})
        @errorHandler = errorHandler

        # Fix needed for the PATCH method to use application/json content type
        defaults = $http.defaults.headers
        defaults.patch = defaults.patch || {}
        defaults.patch['Content-Type'] = 'application/json'

      create: (attrs, successHandler) ->
        new @service(survey: attrs).$save ((survey) -> successHandler(survey)), @errorHandler

      delete: (survey) ->
        new @service().$delete {id: survey.id}, (-> null), @errorHandler

      update: (survey, attrs) ->
        new @service(survey: attrs).$update {id: survey.id}, (-> null), @errorHandler

      all: (callback) ->
        @service.query(callback || (-> null), @errorHandler)

      find: (id, successHandler) ->
        @service.get(id: id, ((survey)->
          successHandler?(survey)
          survey),
        @errorHandler)

      findByGuid: (guid, successHandler) ->
        @service.get(guid: guid, ((survey)->
          successHandler?(survey)
          survey),
        @errorHandler)