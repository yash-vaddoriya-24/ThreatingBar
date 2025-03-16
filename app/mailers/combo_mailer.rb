class ComboMailer < ApplicationMailer
  default from: "yashvaddoriya120@gmail.com"

  def combo_deleted_notification(customer, combo)
    @customer = customer
    @combo = combo

    mail(to: @customer.email, subject: "Your Combo Has Been Deleted")
  end
end
