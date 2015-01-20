# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateBuildWindowHeight = ->
  $content = jQuery('[scroll-lock-content]')
  $header = jQuery('.wrap > header').outerHeight()
  $toolbar = jQuery('[scroll-lock-toolbar]').outerHeight()
  $dropables = jQuery('[scroll-lock-dropables]').outerHeight()
  $padding = 40

  $width = document.documentElement.clientWidth
  $height = document.documentElement.clientHeight - $padding - $toolbar - $dropables

  if $width > 755
    $content.css "height", $height
  else
    $content.removeAttr('style')

lockWindowScroll = ->
  $documentHeight = document.body.offsetHeight
  $windowHeight = window.innerHeight
  $scrollY = window.scrollY
  $body = $(document.body)
  $release = $('#release-button')

  if ($windowHeight + $scrollY) >= $documentHeight
    $body.addClass 'locked'
    $release.fadeIn().click ->
      $body.removeClass 'locked'
      $body.animate
        scrollTop: 0
  else
    $body.removeClass 'locked'
    $release.fadeOut()

$(window)
  .load(updateBuildWindowHeight)
  .resize(updateBuildWindowHeight)
  .scroll(lockWindowScroll)