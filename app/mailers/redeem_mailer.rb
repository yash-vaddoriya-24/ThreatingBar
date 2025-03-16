class RedeemMailer < ApplicationMailer
  default from: "yashvaddoriya120@gmail.com"

  def redeem_confirmation(redeem)
    @redeem = redeem
    @customer = redeem.customer_comb.customer
    @combo = redeem.customer_comb.combo

    mail(to: @customer.email, subject: "Your Combo Has Been Redeemed!")
  end
end
