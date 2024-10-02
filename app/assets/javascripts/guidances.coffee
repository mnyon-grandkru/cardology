window.flipCardBack = (event) ->
  $(event.currentTarget).closest('.panel').toggleClass 'flip'
  $(event.currentTarget).closest('.delivery_zone').toggleClass 'add_height'

window.flipBoxBack = (event) ->
  $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(180deg)')