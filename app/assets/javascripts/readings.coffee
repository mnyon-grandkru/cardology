$(document).on 'turbolinks:load', ->
  setInterval(resizeReading, 50)
  attachFlippers()

window.resizeReading = ->
  $('.panel').each (i, p) ->
    if ($(p).hasClass('flip'))
      $(p).height $(p).find('.card_reading_pane.back').outerHeight() + 30
    else
      $(p).height $(p).find('.card_reading_pane.front').outerHeight() + 30

window.attachFlippers = ->
  $('.card_reading_pane').off('click').on 'click', '.flip_card', (event) ->
    $(this).closest('.panel').toggleClass 'flip'
    $.scrollTo($(this).closest('.panel'), 1000)
    event.preventDefault()