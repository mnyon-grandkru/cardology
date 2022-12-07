class GuidancesController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => lambda { ['lifeelevated.life', 'thesourcecards.com', 'herokuapp.com' , 'blueprint.thesourcecards.com'].include? request.domain }

  def prompt
    @date = rand((50.years.ago)..20.years.ago)
  end
  
  def show
    @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    @@birthdate = @birthday.id
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
  end

  def daily_card
    @birthday = Birthday.find(@@birthdate)
    if params[:day] == 'today'
      @date = DateTime.now
    elsif params[:day] == 'yesterday'
      @date = DateTime.yesterday
    elsif params[:day] == 'tomorrow'
      @date = DateTime.tomorrow
    end
  
  end
  def card52
    @birthday = Birthday.find(@@birthdate)
    if params[:planet] == 'current'
      
    elsif params[:planet] == 'last'
    
    elsif params[:planet] == 'next'
     
    end
  
  end

  def year_card
    @birthday = Birthday.find(@@birthdate)
    if params[:year] == 'current'
      
    elsif params[:year] == 'last'
    
    elsif params[:year] == 'next'
     
    end
  
  end


end
