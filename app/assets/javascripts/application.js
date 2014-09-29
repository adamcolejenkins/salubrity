// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery-ui
//= require turbolinks

// Angular Directives
//= require angular
//= require angular-resource
//= require angular-route
//= require angular-touch
//= require ng-underscore/build/ng-underscore.js
//= require angular-foundation/mm-foundation-tpls
//= require angular-ui-sortable/sortable


// Vendor assets
//= require jquery-icheck/icheck
//= require select2/select2
//= require bootstrap-touchspin/dist/jquery.bootstrap-touchspin

// Our Angular app files
//= require salubrity

//= require_tree .

$(function(){ $(document).foundation(); });
