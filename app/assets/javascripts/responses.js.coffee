# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$URI = new Uri(window.location.href)

$ ->

  # Page Slidedowns
  $('[data-slidedown]').click ->
    $this = $(this)
    $control = $('#' + $this.attr('aria-controls'))

    return if $this.attr('disabled')

    if $this.attr('aria-expanded') is 'false'
      $control.slideDown 400, ->
        $this.attr('aria-expanded', true)
        $this.text($this.data('apply'))

    else if $this.attr('aria-expanded') is 'true'
      $control.slideUp 400, ->
        $this.attr('aria-expanded', false)
        $this.text($this.data('label'))

        $control.find('form').submit()
