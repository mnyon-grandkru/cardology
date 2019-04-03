# Preview all emails at http://localhost:3000/rails/mailers/payment
class PaymentPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/payment/missed
  def missed
    PaymentMailer.missed
  end

end
