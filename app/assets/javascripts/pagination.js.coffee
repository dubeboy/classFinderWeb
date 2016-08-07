if $('#with-button').size() > 0
  $('.pagination').hide()
  loading_items = false

  $('#load_more_items').show().click ->
    unless loading_items
      loading_items = true
      more_items_url = $('.pagination .next_page a').attr('href')
      $this = $(this)
      $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled')
      $.getScript more_items_url, ->
        $this.text('More posts').removeClass('disabled') if $this
        loading_items = false
return