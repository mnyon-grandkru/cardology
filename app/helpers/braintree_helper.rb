module BraintreeHelper

  def checkout_form
    braintree_dropin +
    form_with(:url => "/checkouts", :id => "payment-form") do |subscription_form|
      tag.div(:id => 'bt-dropin') +
      subscription_form.hidden_field :id => 'nonce', :name => 'payment_method_nonce'
      subscription_form.submit
    end
  end
  
  def braintree_dropin
    tag.script(:src => "https://js.braintreegateway.com/web/dropin/1.2.0/js/dropin.min.js") +
    tag.script do
      "$.ajax({
        url: '#{new_subscription_path}',
        success: function(data) {
          braintreeClientToken = data.client_token;
          initializeBraintree();
        }
      })"
    end
  end
  
end
