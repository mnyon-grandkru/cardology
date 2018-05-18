class MemberMailer < ApplicationMailer
  def temporary_password member
    @password = Member.generate_password
    mail :to => member.email, :subject => 'Life Elevated'
  end
  
  def salon
    @member = params[:member]
    @salon_url = ENV['PLAYERS_CLUB_SALON_URL']
    mail :to => @member.email, :subject => 'Life Elevated Salon Access'
  end
end
