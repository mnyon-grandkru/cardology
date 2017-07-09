class SubscriptionsController < ApplicationController
  def new
    render :json => {:client_token => Braintree::ClientToken.generate}
  end
  
  def create
    @member = Member.find params[:member_id]
    customer_creation = Braintree::Customer.create(
      :first_name => @member.name,
      :email => @member.email,
      :payment_method_nonce => params[:payment_method_nonce]
    )
    if customer_creation.success?
      @member.braintree_id = customer_creation.customer.id
      token = customer_creation.customer.payment_methods[0].token
      
      subscription_creation = Braintree::Subscription.create(
        :payment_method_token => token,
        :plan_id => ENV['BRAINTREE_SUBSCRIPTION_PLAN']
      )
      
      if subscription_creation.success?
        @member.subscription_status = 'active'
        @message = "#{view_context.marketing_text('subscription', 'transaction', 'succeeded_first')}#{@member.birthday.card_for_today.name}#{view_context.marketing_text('subscription', 'transaction', 'succeeded_second')}"
      else
        @message = view_context.marketing_text('subscription', 'transaction', 'failed')
      end
    else
      p customer_creation.errors
    end
    @member.save
  end
  
  def cancel
    @member = Member.find params[:member_id]
    @customer = Braintree::Customer.find @member.braintree_id
    subscriptions = Braintree::Subscription.search do |search|
      search.plan_id.is ENV['BRAINTREE_SUBSCRIPTION_PLAN']
    end
    
    member_subscriptions = subscriptions.select { |subscription| subscription.transactions.last.customer_details.id == @customer.id rescue nil }.compact
    if member_subscriptions.present?
      member_subscriptions.each do |subscription|
        cancellation_result = Braintree::Subscription.cancel subscription.id
        Rails.logger.info cancellation_result.inspect
      end
      @member.subscription_status = 'cancelled'
      @member.save
    end
    redirect_to @member.birthday
  end
end
