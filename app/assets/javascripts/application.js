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
//= require jquery-ui/sortable
//= require turbolinks
//= require moment
//= require foundation-daterangepicker/moment.min
//= require classie
//= require fastclick
//= require foundation

// Angular Directives
//= require angular
//= require angular-cookie
//= require angular-resource
//= require angular-sanitize
//= require angular-route
//= require angular-touch
//= require angular-animate
//= require angular-foundation/mm-foundation-tpls
//= require angular-ui-select
//= require angular-ui-sortable/sortable
//= require dataTables/jquery.dataTables
//= require datatables-plugins/integration/foundation/dataTables.foundation
//= require responsive-tables/responsive-tables
//= require ng-s3upload

// Vendor assets
// = require select2
//= require jquery-icheck/icheck
//= require selectfx.js/dist/js/selectfx
//= require sweetalert
//= require nouislider
//= require foundation-daterangepicker/daterangepicker
//= require jsUri

// Our Angular app files
//= require angular/salubrity

//= require_tree .

$(function() {
  $(document).foundation({
    equalizer : {
      // Specify if Equalizer should make elements equal height once they become stacked.
      equalize_on_stack: true
    }
  });
});

Highcharts.dateFormat('%b %e', '%l %P', false)
Highcharts.setOptions({
  global: {
    useUTC: false
  }
});