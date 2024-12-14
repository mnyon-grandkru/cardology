var braintreeClientToken, initializeBraintree, initializeCheckout, initializeContainers;

braintreeClientToken = void 0;

initializeBraintree = function(dropin) {
  braintree.dropin.create({
    authorization: braintreeClientToken,
    container: dropin,
    paypal: {
      flow: 'vault'
    },
    cards: false
  }, function(createErr, instance) {
    $('.braintree_container').on('submit', '.subscription_payment', function(event) {
      var activated_form;
      activated_form = this;
      event.preventDefault();
      $('.braintree_container').off('submit');
      instance.requestPaymentMethod(function(err, payload) {
        if (err) {
          console.log('Error', err);
          return;
        }
        $('.nonce').val(payload.nonce);
        $(activated_form).submit();
      });
    });
  });
  $('.pane, .payment').on('click', '.subscribe', function() {
    $(this).prev('.braintree_container').show();
    $(this).hide();
    return false;
  });
  return false;
};

initializeCheckout = function(dropin) {
  $.ajax({
    url: Routes.new_subscription_path(),
    success: function(data) {
      braintreeClientToken = data.client_token;
      initializeBraintree(dropin);
    }
  });
};

initializeContainers = function() {
  $.each($('.braintree_container'), function(i, container) {
    var id;
    id = '#bt-dropin-' + (i + 1);
    initializeCheckout(id);
  });
};

$(document).on('turbo:load', function() {
  initializeContainers();
});

$(document).on('payment:setup', function() {
  initializeContainers();
});