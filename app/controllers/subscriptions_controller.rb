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
        @message = "Thank you for becoming a member!  Your card for today is #{@member.card_for_today.name}.  You can also look into the future at your upcoming cards."
      else
        @message = "Your transaction was not completed.  This may be due to bank security measures, which are very tight these days.  If you use a different payment method or contact your bank, perhaps the next attempt will succeed."
      end
    else
      p result.errors
    end
    @member.save
  end
  
  def cancel
    
  end
end
