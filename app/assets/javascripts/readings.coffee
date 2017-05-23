$(document).on 'turbolinks:load', ->
  setTimeout(resizeReading, 150)
  $('.card_reading_pane').on 'click', '.flip_card', ->
    $(this).closest('.panel').toggleClass 'flip'
    $.scrollTo($(this).closest('.panel'), 1000)
    setTimeout(resizeReading, 50)

resizeReading = ->
  $('.panel').each (i, p) ->
    $(p).height $(p).find('.card_reading_pane').outerHeight() + 30
    return
