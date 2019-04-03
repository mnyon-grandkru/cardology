$(document).on 'turbolinks:load', ->
  $('.subscription_management_for_member').on 'click', '#exit_interview_initiate', ->
    $('.panel').each (i, p) ->
      $(p).height 100
