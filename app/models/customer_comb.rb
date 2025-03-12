class CustomerComb < ApplicationRecord
  belongs_to :customer
  belongs_to :combo
  has_many :redeems, dependent: :destroy # Track redemptions

  def redeem
    Redeem.create!(customer_combo: self)
  end
end
