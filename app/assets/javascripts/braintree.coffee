braintreeClientToken = undefined

initializeBraintree = ->
  client_token = braintreeClientToken
  braintree.dropin.create {
    authorization: client_token
    container: '#bt-dropin'
    paypal: flow: 'vault'
  }, (createErr, instance) ->
    $(document).on 'submit', '#subscription_form', (event) ->
      event.preventDefault()
      instance.requestPaymentMethod (err, payload) ->
        if err
          console.log 'Error', err
          return
        $('#nonce').val payload.nonce
        $('#subscription_form').submit()
        return
      return
    return
  checkout = new Demo(formID: 'subscription_form')

  $('.pane').on 'click', '.subscribe', ->
    console.log('bram')
    $('#subscription_form').trigger 'submit'
