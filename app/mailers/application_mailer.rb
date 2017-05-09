class ApplicationMailer < ActionMailer::Base
  default from: ENV['CUSTOMER_SUPPORT_EMAIL_ADDRESS']
  layout 'mailer'
end
