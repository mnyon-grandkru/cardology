class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, :if => lambda { request.domain == 'herokuapp.com' }
end
