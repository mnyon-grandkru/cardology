$(document).on 'turbolinks:load', ->
  $('#simplero_delivery').validate()
  $('#signup').on 'submit', '#simplero_delivery', (event) ->
    $.ajax
      url: '/member_save'
      method: 'POST'
      data:
        member:
          birthday_id: $('div.birthday').data('birthday_id')
          name: $('#first_names').val()
          email: $('#email').val()
          lookup_id: $('div.birthday').data('lookup_id')
    
    $.ajax
      url: 'https://sourcecards.simplero.com/optin/b24zsq7f18NUxEhYeC56YbMi/173105'
      method: 'POST'
      data:
        $(this).serialize()
    
    event.preventDefault()

  $('.joining_players_club').on 'click', ->
    $('#member_first_name').focus();

  if $('#time_zone')
    $('#time_zone').val moment().format('Z')
