class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDING_EMAIL_ADDRESS']
  layout 'mailer'
end
