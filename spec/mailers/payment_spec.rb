require "rails_helper"

RSpec.describe PaymentMailer, type: :mailer do
  describe "missed" do
    let(:member) { Fabricate :member }
    let(:mail) { PaymentMailer.with(:member => member).missed }

    it "renders the headers" do
      expect(mail.subject).to eq "Uh Oh! There was a problem with your Players Club subscription!"
      expect(mail.to).to eq [member.email]
      expect(mail.from).to eq [ENV['SENDING_EMAIL_ADDRESS']]
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
