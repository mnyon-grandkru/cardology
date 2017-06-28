braintreeClientToken = undefined

initializeBraintree = ->
  braintree.dropin.create {
    authorization: braintreeClientToken
    container: '#bt-dropin'
    paypal: flow: 'vault'
  }, (createErr, instance) ->
    $('#braintree_container').on 'submit', '#subscription_payment', (event) ->
      event.preventDefault()
      $('#braintree_container').off 'submit'
      instance.requestPaymentMethod (err, payload) ->
        if err
          console.log 'Error', err
          return
        $('#nonce').val payload.nonce
        $('#subscription_payment').submit()
        return
      return
    return

  $('.pane').on 'click', '.subscribe', ->
    $('#braintree_container').show()
    $('#braintree_container').focus()
    $('.birth_card_for_birthday .subscribe').hide()

$(document).on 'turbolinks:load', ->
  $.ajax
    url: Routes.new_subscription_path()
    success: (data) ->
      braintreeClientToken = data.client_token
      initializeBraintree()
      return
  return
