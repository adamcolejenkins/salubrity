@salubrity
  
  .factory 'ProviderService', ($resource, $http, $filter) ->

    class Provider
      constructor: (errorHandler) ->
        @service = $resource('/providers/:id.json',
          {id: '@id'},
          {update: {method: 'PATCH'}})
        @errorHandler = errorHandler

        # Fix needed for the PATCH method to use application/json content type
        defaults = $http.defaults.headers
        defaults.patch = defaults.patch || {}
        defaults.patch['Content-Type'] = 'application/json'

      create: (attrs, successHandler) ->
        new @service(provider: attrs).$save ((provider) -> attrs.id = provider.id), @errorHandler

      delete: (provider) ->
        new @service().$delete {id: provider.id}, (-> null), @errorHandler

      update: (provider, attrs) ->
        new @service(provider: attrs).$update {id: provider.id}, (-> null), @errorHandler

      all: (callback) ->
        @service.query(callback || (-> null), @errorHandler)

      find: (id, successHandler) ->
        @service.get(id: id, ((provider)->
          successHandler?(provider)
          provider),
        @errorHandler)