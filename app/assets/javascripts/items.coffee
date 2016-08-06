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

# Rails creates this event, when the link_to(remote: true)
# successfully executes
$(document).on 'ajax:success', 'a.like', (status,data,xhr)->
# the `data` parameter is the decoded JSON object
  $(".likes-count[data-id=#{data.id}]").text data.likes
  return

jQuery ->
  if $('#infinity-scroll').size() > 0
    $(window).on 'scroll', ->
      more_items_url = $('.pagination .next_page a').attr('href')
      if more_items_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_items_url
    return
  return
