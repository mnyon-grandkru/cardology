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
        @member.add_to_players_club_campaign
        @message = "#{view_context.marketing_text('subscription', 'transaction', 'succeeded_first')}#{@member.birthday.card_for_today.name}#{view_context.marketing_text('subscription', 'transaction', 'succeeded_second')}"
      else
        @message = view_context.marketing_text('subscription', 'transaction', 'failed')
      end
    else
      p customer_creation.errors
    end
    @member.save
  end
  
  def update
    @member = Member.find params[:member_id]
    @customer = Braintree::Customer.find @member.braintree_id
    customer_update = Braintree::Customer.update(
      @customer.id,
      :payment_method_nonce => params[:payment_method_nonce]
    )
    if customer_update.success?
      token = customer_update.customer.payment_methods.last.token
      
      subscriptions = Braintree::Subscription.search do |search|
        search.plan_id.is ENV['BRAINTREE_SUBSCRIPTION_PLAN']
      end
    
      member_subscriptions = subscriptions.select { |subscription| subscription.transactions.last.customer_details.id == @customer.id rescue nil }.compact
      if member_subscriptions.present?
        member_subscriptions.each do |subscription|
          subscription_update = Braintree::Subscription.update(
            subscription.id,
            :payment_method_token => token
          )
          
          if subscription_update.success?
            @member.update_attribute :subscription_status, 'active'
            @message = view_context.marketing_text('subscription', 'update', 'succeeded')
          end
        end
      end
    end
    @message ||= view_context.marketing_text('subscription', 'update', 'failed')
  end
  
  def manage
    @member = Member.find params[:member_id]
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
      @member.subscription_status = 'canceled'
      @member.save
    end
    redirect_to @member.birthday
  end
end
