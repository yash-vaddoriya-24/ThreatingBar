class Service < ApplicationRecord
  has_many :combos, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
