module BraintreeHelper
  def checkout_form subscription = nil
    if subscription
      submission_path = subscription_path subscription
      submission_method = :patch
    else
      submission_path = subscriptions_path
      submission_method = :post
    end
    if braintree_enabled?
      content_tag(:div, :class => 'braintree_container') do
        form_with(:url => submission_path, :class => "subscription_payment", :method => submission_method) do |subscription_form|
          tag.div(:id => "bt-dropin-#{dropin_count}") +
          subscription_form.hidden_field(:payment_method_nonce, :class => 'nonce') +
          subscription_form.hidden_field(:member_id, :value => @member.id) +
          subscription_form.submit(marketing_text('subscription', 'checkout', 'submit'), :id => 'subscribe_button')
        end
      end
    end
  end
  
  def payment_method_update_form member
    content_tag(:div) do
      checkout_form(member) +
      link_to(marketing_text('subscription', 'update', 'accept'), 'javascript: null', :class => 'subscribe call_to_action trailing lunar_navigation')
    end
  end
  
  def braintree_script
    tag.script :src => "https://js.braintreegateway.com/web/dropin/1.9.4/js/dropin.min.js"
  end
  
  def dropin_count
    @dropin_count = @dropin_count.to_i + 1
  end
  
  def braintree_enabled?
    ENV['BRAINTREE_ENABLED'] == 'true'
  end
end
