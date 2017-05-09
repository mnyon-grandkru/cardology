class MemberMailer < ApplicationMailer
  def temporary_password member
    @password = Member.generate_password
    mail(to: member.email, subject: 'Life Elevated')
  end
end
