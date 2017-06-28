module BraintreeHelper

  def checkout_form
    if braintree_enabled?
      content_tag :div, :id => 'braintree_container' do
        braintree_dropin +
        form_with(:url => subscriptions_path, :id => "subscription_payment") do |subscription_form|
          tag.div(:id => 'bt-dropin') +
          subscription_form.hidden_field(:payment_method_nonce, :id => 'nonce') +
          subscription_form.hidden_field(:member_id, :value => @member.id) +
          subscription_form.submit('Join to see your Daily Card!', :id => 'subscribe_button')
        end
      end
    end
  end
  
  def braintree_dropin
    tag.script :src => "https://js.braintreegateway.com/web/dropin/1.2.0/js/dropin.min.js"
  end
  
  def braintree_enabled?
    ENV['BRAINTREE_ENABLED'] == 'true'
  end
end
