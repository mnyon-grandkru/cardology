$(document).on 'turbolinks:load', ->
  resizeReading
  $('.card_reading_pane').on 'click', '.flip_card', ->
    $(this).closest('.panel.' + $(this).data('reading')).toggleClass 'flip'
    resizeReading

resizeReading = ->
  $('.panel').each (i, p) ->
    $(p).height $('.card_reading_pane').outerHeight()
    return
