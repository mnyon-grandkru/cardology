$(document).on 'turbolinks:load', ->
  setTimeout(resizeReading, 100)
  $('.card_reading_pane').on 'click', '.flip_card', ->
    $(this).closest('.panel.' + $(this).data('reading')).toggleClass 'flip'
    resizeReading()

resizeReading = ->
  $('.panel').each (i, p) ->
    $(p).height $(p).find('.card_reading_pane').outerHeight() + 20
    return
