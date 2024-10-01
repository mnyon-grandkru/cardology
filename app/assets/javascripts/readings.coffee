$(document).on 'turbolinks:load', ->
  setInterval(resizeReading, 50)
  attachFlippers()
  
  $('#upgrade_button').on 'click', (event) ->
    $('#first_card_panel').toggleClass 'flip'
    # $.scrollTo($('#first_card_panel'), 1000)
    event.preventDefault()
    
  $('#new_birthday').on 'submit', (event) ->
    if($('#reading_type').val() == 'Personality Card')
      event.preventDefault()
      formData = $(this).serialize()
      $.ajax
        url: '/guidances/show?prompt=true'
        method: 'POST'
        data: formData
        success: (response) ->
          eval(response)
        

window.resizeReading = ->
  $('.panel').each (i, p) ->
    image_height = $(p).find('img.source_cards_card_design').height()
    title_line_height = $(p).find('.title_line').height()
    if ($(p).hasClass('flip'))
      $(p).height $(p).find('.pane.back').outerHeight() + 30 + image_height + title_line_height
    else
      if ($(p).hasClass('skip'))
        $(p).height $(p).find('.pane.fore').outerHeight() + 30
      else
        $(p).height $(p).find('.pane.front').outerHeight() + 30 + image_height

window.attachFlippers = ->
  $('.card_reading_pane, .delivery_zone').off('click').on 'click', '.flip_card', (event) ->
    $(this).closest('.panel').toggleClass 'flip'
    # $.scrollTo($(this).closest('.panel'), 1000)
    event.preventDefault()
  
  $('.card_reading_pane, .delivery_zone').on 'click', '.skip_card', (event) ->
    $(this).closest('.panel').toggleClass 'skip'
    # $.scrollTo($(this).closest('.panel'), 1000)
    event.preventDefault()

window.cinderellaFlip = ->
  $('.panel.birth').removeClass 'skip'
  $('.panel.birth').addClass 'flip'
