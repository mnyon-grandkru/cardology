class GuidancesController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => lambda { ['lifeelevated.life', 'thesourcecards.com', 'herokuapp.com' , 'blueprint.thesourcecards.com'].include? request.domain }

  def prompt
    @date = rand((50.years.ago)..20.years.ago)
  end
  
  def show
    @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    @@birthdate = @birthday
    
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
  end

  def browse 
    @member = current_member
    @birthday = @@birthdate
    if params[:day] == 'today'
      

      @date = DateTime.now
    elsif params[:day] == 'yesterday'
    
      @date = DateTime.yesterday

    elsif params[:day] == 'tomorrow'
   
      @date = DateTime.tomorrow


    end
end
end
