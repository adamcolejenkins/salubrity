# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



@salubrity = angular.module 'salubrity', [
  'ngResource', 'ngRoute', 'mm.foundation', 'ui.select', 'ui.sortable', 'ngSanitize', 'ngTouch', 'ngS3upload', 'ipCookie'
]


# This sets the CSRF header for Rails
@salubrity.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken


# Here we define our main route
@salubrity.config ($locationProvider) ->

  # Enable HTML5mode
  # $locationProvider.html5Mode true


# Set the AWS Upload theme
@salubrity.config (ngS3Config, uiSelectConfig) ->

  # We will use the Bootstrap3 theme
  # TODO: Create own theme
  ngS3Config.theme = 'flatdream'
  uiSelectConfig.theme = 'select2'
  uiSelectConfig.resetSearchInput = true


# Angular run methods
@salubrity.run ($rootScope) ->


# Main App controller
@salubrity.controller 'AppCtrl', ($scope, $rootScope) ->


# Makes AngularJS work with turbolinks.
$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])