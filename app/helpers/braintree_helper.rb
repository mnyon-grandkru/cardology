module BraintreeHelper

  def checkout_display_button
    link_to marketing_text('subscription', 'checkout', 'button'), "javascript: $('#braintree_container').show();", :class => 'subscribe call_to_action trailing lunar_navigation'
  end

  def checkout_form
    if braintree_enabled?
      content_tag(:div, :id => 'braintree_container') do
        braintree_dropin +
        form_with(:url => subscriptions_path, :id => "subscription_payment") do |subscription_form|
          tag.div(:id => 'bt-dropin') +
          subscription_form.hidden_field(:payment_method_nonce, :id => 'nonce') +
          subscription_form.hidden_field(:member_id, :value => @member.id) +
          subscription_form.submit(marketing_text('subscription', 'checkout', 'submit'), :id => 'subscribe_button')
        end
      end +
      checkout_display_button
    end
  end
  
  def braintree_dropin
    tag.script :src => "https://js.braintreegateway.com/web/dropin/1.2.0/js/dropin.min.js"
  end
  
  def braintree_enabled?
    ENV['BRAINTREE_ENABLED'] == 'true'
  end
end
