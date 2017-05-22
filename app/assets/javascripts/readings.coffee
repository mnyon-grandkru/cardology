$(document).on 'turbolinks:load', ->
  setTimeout(resizeReading, 150)
  $('.card_reading_pane').on 'click', '.flip_card', ->
    $(this).closest('.panel.' + $(this).data('reading')).toggleClass 'flip'
    $.scrollTo($(this).closest('.panel'), 1000)
    resizeReading()

resizeReading = ->
  $('.panel').each (i, p) ->
    $(p).height $(p).find('.card_reading_pane').outerHeight() + 20
    return
