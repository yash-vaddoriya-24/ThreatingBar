class Customer < ApplicationRecord
  has_many :customer_combs
  has_many :combos, through: :customer_combs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "must be exactly 10 digits" }
end
