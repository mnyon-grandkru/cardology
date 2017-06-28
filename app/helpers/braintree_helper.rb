module BraintreeHelper
  def checkout_form
    if braintree_enabled?
      content_tag(:div, :class => 'braintree_container') do
        braintree_dropin +
        form_with(:url => subscriptions_path, :class => "subscription_payment") do |subscription_form|
          tag.div(:id => "bt-dropin-#{dropin_count}") +
          subscription_form.hidden_field(:payment_method_nonce, :class => 'nonce') +
          subscription_form.hidden_field(:member_id, :value => @member.id) +
          subscription_form.submit(marketing_text('subscription', 'checkout', 'submit'), :id => 'subscribe_button')
        end
      end
    end
  end
  
  def braintree_dropin
    tag.script :src => "https://js.braintreegateway.com/web/dropin/1.2.0/js/dropin.min.js"
  end
  
  def dropin_count
    @dropin_count = @dropin_count.to_i + 1
  end
  
  def braintree_enabled?
    ENV['BRAINTREE_ENABLED'] == 'true'
  end
end
