$(document).on 'turbolinks:load', ->
  $('.card_reading_pane').on 'click', '.flip_card', ->
    $(this).closest('.panel.' + $(this).data('reading')).addClass 'flip'
