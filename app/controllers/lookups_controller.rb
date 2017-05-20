class LookupsController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => lambda { request.domain == 'lifeelevated.life' }
  
  def cusp_select
    
  end
  
  def update
    @lookup = Lookup.find params[:id]
    @member = Member.new member_params
    @member.lookup = @lookup
    @member.birthday = @lookup.birthday
    @member.password = Member.generate_password
    @member.password_confirmation = @member.password
    @member.save
    redirect_to @member.birthday
  end
  
  protected
  
  def member_params
    params.require(:member).permit(:name, :email)
  end
end
