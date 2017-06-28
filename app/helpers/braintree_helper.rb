module BraintreeHelper

  def checkout_form
    braintree_dropin +
    form_with(:url => subscriptions_path, :id => "payment-form") do |subscription_form|
      tag.div(:id => 'bt-dropin') +
      subscription_form.hidden_field(:payment_method_nonce, :id => 'nonce') +
      subscription_form.hidden_field(:member_id, :value => @member.id) +
      subscription_form.submit('Join to see your Daily Card!', :id => 'subscribe_button')
    end
  end
  
  def braintree_dropin
    tag.script(:src => "https://js.braintreegateway.com/web/dropin/1.2.0/js/dropin.min.js") +
    tag.script do
      "$(document).on('turbolinks:load', function() {
        $.ajax({
          url: '#{new_subscription_path}',
          success: function(data) {
            braintreeClientToken = data.client_token;
            initializeBraintree();
          }
        });
      });"
    end
  end
end
