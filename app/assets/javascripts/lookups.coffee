$(document).on 'turbolinks:load', ->
  $('#getresponse_delivery').validate()
  $('.member_form_container').on 'submit', '#getresponse_delivery', (event) ->
    $.ajax
      url: '/member_save'
      method: 'POST'
      data:
        member:
          birthday_id: $('div.birthday').data('birthday_id')
          name: $('#member_first_name').val()
          email: $('#member_email').val()
          lookup_id: $('div.birthday').data('lookup_id')
    
    $.ajax
      url: 'https://app.getresponse.com/add_subscriber.html'
      method: 'POST'
      data:
        $(this).serialize()
    
    event.preventDefault()

  $('.joining_players_club').on 'click', ->
    $('#member_first_name').focus();

  if $('#time_zone')
    $('#time_zone').val moment().format('Z')
