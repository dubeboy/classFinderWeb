# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ($) ->
  $('#myCarousel').carousel interval: 5000
#  $('#carousel-text').html $('#slide-content-0').html()
  #Handles the carousel thumbnails
  $('[id^=carousel-selector-]').click ->
    `var id`
    id = @id.substr(@id.lastIndexOf('-') + 1)
    id = parseInt(id)
    $('#myCarousel').carousel id
    return
  return
