class MembersController < ApplicationController

  def create
    @member = Member.new member_params
    @member.password = Member.generate_password
    @member.password_confirmation = @member.password
    @member.save
    render :nothing => true
  end
  
  private
  
  def member_params
    params.require(:member).permit(:birthday_id, :name, :email)
  end
  
end
