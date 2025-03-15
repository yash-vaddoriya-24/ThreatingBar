class Combo < ApplicationRecord
  belongs_to :service
  has_many :customer_combs, dependent: :destroy
  has_many :customers, through: :customer_combs
  belongs_to :user
  validates :count, numericality: { only_integer: true, greater_than: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, numericality: { greater_than: 0 }
end
