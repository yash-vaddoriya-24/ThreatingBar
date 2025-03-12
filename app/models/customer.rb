class Customer < ApplicationRecord
  has_many :customer_combos
  has_many :combos, through: :customer_combos

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "must be exactly 10 digits" }
  validates :redeem_count, numericality: { greater_than_or_equal_to: 0 }
end
