class Customer < ApplicationRecord
  has_many :customer_combs, dependent: :destroy
  has_many :combos, through: :customer_combs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "must be exactly 10 digits" }

  def self.ransackable_attributes(auth_object = nil)
    %w[name email phone_no] # ✅ Specify only searchable fields
  end
  def self.ransackable_associations(auth_object = nil)
    %w["combos", "customer_combs"]
  end
end
