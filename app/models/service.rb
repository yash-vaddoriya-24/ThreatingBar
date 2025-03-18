class Service < ApplicationRecord
  CATEGORIES = [ "Hair Services", "Skin Care Services", "Waxing Services", "Nails Services" ]
  has_many :combos, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
