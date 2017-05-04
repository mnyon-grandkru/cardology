class MembersController < ApplicationController
  skip_before_action :verify_authenticity_token, :if => lambda { request.domain == 'herokuapp.com' }

  def create
    if @member = Member.find_by_email(member_params[:email])
      sign_in @member
      redirect_to root_url
      return
    end
    
    @member = Member.new member_params
    @member.password = Member.generate_password
    @member.password_confirmation = @member.password
    @member.save
    sign_in @member
    redirect_to birthday_path @member.birthday, :member_id => @member.id, :scroll_to_top => true
  end
  
  def update
    @member = Member.find params[:id]
    @member.update_attributes member_params
    redirect_to birthday_path @member.birthday, :member_id => @member.id
  end
  
  private
  
  def member_params
    params.require(:member).permit(:birthday_id, :name, :email, :lookup_id, :zodiac_sign)
  end
  
end
