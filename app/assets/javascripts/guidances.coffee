window.flipCardBack = (event) ->
  $(event.currentTarget).closest('.panel').toggleClass 'flip'
