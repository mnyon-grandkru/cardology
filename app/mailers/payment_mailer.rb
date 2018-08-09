class PaymentMailer < ApplicationMailer
  include ApplicationHelper
  def missed
    @member = params[:member]
    @subject = marketing_text 'subscription', 'transaction', 'past_due'
    @body = mark_up email_text 'players_club', 'delinquent', 'missed'
    mail :to => @member.email, :subject => @subject, :body => @body, :content_type => 'text/html'
  end
  
  def unresolved
    @member = params[:member]
    @subject = marketing_text 'subscription', 'transaction', params[:timing]
    @body = mark_up email_text 'players_club', 'delinquent', params[:timing]
    mail :to => @member.email, :subject => @subject, :body => @body, :content_type => 'text/html'
  end
end
