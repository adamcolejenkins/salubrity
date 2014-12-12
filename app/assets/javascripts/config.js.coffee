# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateSidebar = ->
  $header = jQuery('.wrap > header').outerHeight()
  $main = jQuery('.wrap > main').height()

  $width = document.documentElement.clientWidth
  $height = document.documentElement.clientHeight - $header 

  if $width > 755
    if $main > $height
      jQuery('section.sidebar').css "min-height", $main
    else
      jQuery('section.sidebar').css "min-height", $height
  else
    jQuery('section.sidebar').removeAttr('style')


$(window)
  .load(updateSidebar)
  .resize(updateSidebar)