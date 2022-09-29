class GuidancesController < ApplicationController
  def prompt
    @date = rand((50.years.ago)..20.years.ago)
  end
  
  def show
    @birthday = Birthday.find_or_create_by :year => params['birthday']['date(1i)'], :month => params['birthday']['date(2i)'], :day => params['birthday']['date(3i)']
    @lookup = Lookup.create :birthday => @birthday, :ip_address => request.remote_ip
  end
end
