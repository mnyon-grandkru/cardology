$(document).on 'turbolinks:load', ->
  setInterval(resizeReading, 50)
  attachFlippers()
  
  $('#upgrade_button').on 'click', (event) ->
    $('#first_card_panel').toggleClass 'flip'
    $.scrollTo($('#first_card_panel'), 1000)
    event.preventDefault()

window.resizeReading = ->
  $('.panel').each (i, p) ->
    if ($(p).hasClass('flip'))
      $(p).height $(p).find('.pane.back').outerHeight() + 30
    else
      if ($(p).hasClass('skip'))
        $(p).height $(p).find('.pane.fore').outerHeight() + 30
      else
        $(p).height $(p).find('.pane.front').outerHeight() + 30

window.attachFlippers = ->
  $('.card_reading_pane').off('click').on 'click', '.flip_card', (event) ->
    $(this).closest('.panel').toggleClass 'flip'
    $.scrollTo($(this).closest('.panel'), 1000)
    event.preventDefault()
  
  $('.card_reading_pane').on 'click', '.skip_card', (event) ->
    $(this).closest('.panel').toggleClass 'skip'
    $.scrollTo($(this).closest('.panel'), 1000)
    event.preventDefault()

window.cinderellaFlip = ->
  $('.panel.birth').removeClass 'skip'
  $('.panel.birth').addClass 'flip'
