$(document).on 'turbolinks:load', ->
  $('.subscription_management_for_member').on 'click', '#exit_interview_initiate', ->
    $('.subscription_management_for_member').slideUp(2000)
    $('#cancellation_policy').slideUp(2000)
