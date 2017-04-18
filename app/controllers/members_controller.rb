class MembersController < ApplicationController

  def accept_getresponse_data
    Rails.logger.info("Here is the redirected data from GetResponse:")
    Rails.logger.info(params)
  end
  
end
