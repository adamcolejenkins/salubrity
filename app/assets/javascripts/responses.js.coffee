# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

responseDataHeight = ->
  $header = jQuery('.wrap > header').outerHeight()

  $width = document.documentElement.clientWidth
  $height = document.documentElement.clientHeight - $header

  if $width > 755
    jQuery('section.response-data').css "min-height", $height
  else
    jQuery('section.response-data').removeAttr('style')

$ ->
  $('[data-slidedown]').click ->
    $this = $(this)

    return if $this.attr('disabled')

    if $this.attr('aria-expanded') is 'false'
      $('#' + $this.attr('aria-controls')).slideDown()
      $this.attr('aria-expanded', true)
      $this.text($this.data('apply'))

    else if $this.attr('aria-expanded') is 'true'
      $('#' + $this.attr('aria-controls')).slideUp()
      $this.attr('aria-expanded', false)
      $this.text($this.data('label'))

  console.log $('#response-table').data('sort-disabled')

  $( '#response-table' ).dataTable
    processing: true
    serverSide: true
    ajax: $('#response-table').data('source')
    pagingType: 'full_numbers'
    scrollX: true,
    scrollY: "500px"
    scrollCollapse: true
    autoWidth: false
    pageLength: 50
    lengthMenu: [ [50, 100, 150, -1], [50, 100, 150, "All"] ]
    order: [ 1, 'desc' ]
    columnDefs: [
      { "orderable": false, "targets": $('#response-table').data('sort-disabled') }
    ]


# Set Response Data table height
$(window)
  .load(responseDataHeight)
  .resize(responseDataHeight)