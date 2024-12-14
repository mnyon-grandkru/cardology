$(document).on('turbo:load', function() {
  $('.subscription_management_for_member').on('click', '#exit_interview_initiate', function() {
    $('.subscription_management_for_member').slideUp(2000);
    return $('#cancellation_policy').slideUp(2000);
  });
  
  $('#exit_interview').on('click', '#interview_submission', function(event) {
    event.preventDefault();
    return $('form.interview').submit();
  });
});