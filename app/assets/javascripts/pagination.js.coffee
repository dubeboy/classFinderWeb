jQuery ->
  if $('#infinity-scroll').size() > 0
    $(window).on 'scroll', ->
      more_items_url = $('.pagination .next_page a').attr('href')
      if more_items_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_items_url
    return
  return