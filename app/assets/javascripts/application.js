// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-material-design
//= require_tree .

$.material.init();

var loading_items;

$(document).ready(function() {

   var pagination =  $('.pagination');
    pagination.hide();

    if ($('#infinity-scroll').size() > 0  ) {
        if (pagination.length) {
            $(window).scroll(function () {
                var url = $('.pagination >  .next_page' ).attr('href');
                if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
                    $('.pagination').text(" Loading ");
                    return $.getScript(url);
                }
            });
        }
    }



    if ($('#with_button').size() > 0  ) {
          loading_items = false;
          $('#load_more_items').show().click(function() {
              var $this, more_items_url;
              if (!loading_items) {
                  loading_items = true;
                  more_items_url = $('.pagination .next_page').attr('href');
                  $this = $(this);
                  $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled');
                  $.getScript(more_items_url, function() {
                      if ($this) {
                          $this.text('More Items').removeClass('disabled');
                      }
                      return loading_items = false;
                  });
              }
          });
    }

    $('.grid').masonry({
        // options
        itemSelector: '.item',
         columnWidth: '.item'
    });

    // #todo refactor cmn code
    $('#secureSubmit').click(function() {
        $("#secureRoom .close").click()
    });

    $('#viewBooking').click(function() {
        $("#secureRoom .close").click()
    });
});
