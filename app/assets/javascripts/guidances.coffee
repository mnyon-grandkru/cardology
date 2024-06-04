window.flipCardBack = (event) ->
  $(event.currentTarget).closest('.panel').toggleClass 'flip'
  $(event.currentTarget).closest('.delivery_zone').toggleClass 'add_height'
