module BraintreeHelper
  def payment_form path, verb, call_to_action
    if braintree_enabled?
      content_tag(:div, :class => 'braintree_container') do
        form_with(:url => path, :class => "subscription_payment", :method => verb) do |subscription_form|
          tag.div(:id => "bt-dropin-#{dropin_count}") +
          subscription_form.hidden_field(:payment_method_nonce, :class => 'nonce') +
          subscription_form.hidden_field(:member_id, :value => @member.id) +
          subscription_form.submit(call_to_action, :id => 'subscribe_button')
        end
      end
    end
  end
  
  def checkout_form
    payment_form subscriptions_path, :post, marketing_text('subscription', 'checkout', 'submit')
  end
  
  def payment_method_update_form member
    payment_form(subscription_path(member), :patch, marketing_text('subscription', 'update', 'submit'))
  end
  
  def dropin_count
    @dropin_count = @dropin_count.to_i + 1
  end
  
  def braintree_enabled?
    ENV['BRAINTREE_ENABLED'] == 'true'
  end
end
