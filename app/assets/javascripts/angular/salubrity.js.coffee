# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



@salubrity = angular.module 'salubrity', [
  'ngResource', 'ui.router', 'ui.bootstrap', 'ui.sortable', 'ngTouch', 'ngS3upload', 'ngAnimate'
]


# This sets the CSRF header for Rails
@salubrity.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken


# Here we define our main route
@salubrity.config ($urlRouterProvider, $locationProvider) ->

  # Enable HTML5mode
  $locationProvider.html5Mode true;

  # If no route, redirect to /
  $urlRouterProvider.otherwise '/'


# Set the AWS Upload theme
@salubrity.config (ngS3Config) ->

  # We will use the Bootstrap3 theme
  # TODO: Create own theme
  ngS3Config.theme = 'flatdream'


# Angular run methods
@salubrity.run ($rootScope, $state) ->

  # On routeChangeSuccess, set our current controller, action && id
  $rootScope.$on '$stateChangeSuccess', ->
    ctrl = $state.current.controller.split(/(?=[A-Z])/).map (s) ->
      s.toLowerCase()
    ctrl.pop()

    $rootScope.controller = ctrl[0]
    $rootScope.action = ctrl[1]
    $rootScope.id = $state.params.id

# Main App controller
@salubrity.controller 'AppCtrl', ($scope, $rootScope) ->
  
  # Helper functions for determining current page, ctrl & action
  $scope.current = 

    page: (ctrl, action) ->
      true if ($rootScope.controller == ctrl) && ($rootScope.action == action)

    ctrl: (ctrl) ->
      true if $rootScope.controller == ctrl

    action: (action) ->
      true if $rootScope.action == action

    id: (id) ->
      true if $rootScope.id && ($rootScope.id == id)


# Makes AngularJS work with turbolinks.
$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])