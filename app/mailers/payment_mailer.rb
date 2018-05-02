class PaymentMailer < ApplicationMailer
  include ApplicationHelper
  def missed
    @member = params[:member]
    mail :to => @member.email, :subject => marketing_text('subscription', 'transaction', 'past_due')
  end
end
