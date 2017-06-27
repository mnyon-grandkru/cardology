class SubscriptionsController < ApplicationController
  def new
    render :json => {:client_token => Braintree::ClientToken.generate}
  end
  
  def create
    
  end
  
  def cancel
    
  end
end
