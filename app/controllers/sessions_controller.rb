class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, :if => lambda { request.domain == 'herokuapp.com' }
  
  def auth_options
    { scope: resource_name, recall: "birthdays#second_try" }
  end
end
