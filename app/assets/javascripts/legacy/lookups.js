$(document).on('turbolinks:load', function() {
  $('#simplero_delivery').validate();
  $('#signup').on('submit', '#simplero_delivery', function(event) {
    $.ajax({
      url: 'https://sourcecards.simplero.com/optin/b24zsq7f18NUxEhYeC56YbMi/173105',
      method: 'POST',
      data: $(this).serialize()
    });
    setTimeout((function() {
      $.ajax({
        url: '/member_save',
        method: 'POST',
        data: {
          member: {
            birthday_id: $('div.birthday').data('birthday_id'),
            name: $('#first_names').val(),
            email: $('#email').val(),
            lookup_id: $('div.birthday').data('lookup_id')
          }
        }
      });
    }), 100);
    event.preventDefault();
  });
  $('.joining_players_club').on('click', function() {
    $('#member_first_name').focus();
  });
  if ($('#time_zone')) {
    $('#time_zone').val(moment().format('Z'));
  }
});