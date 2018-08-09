class MemberMailer < ApplicationMailer
  include ApplicationHelper
  def temporary_password
    @member = params[:member]
    @password = Member.generate_password
    @subject = 'Life Elevated'
    @body = mark_up email_text 'widget', 'membership', 'begins'
    mail :to => @member.email, :subject => @subject, :body => @body, :content_type => 'text/html'
  end
  
  def salon
    @member = params[:member]
    @salon_url = ENV['PLAYERS_CLUB_SALON_URL']
    mail :to => @member.email, :subject => 'Life Elevated Salon Access'
  end
end
