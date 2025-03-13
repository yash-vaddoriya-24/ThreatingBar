class Service < ApplicationRecord
  SERVICE_NAMES = ["Haircut", "Beard Trim", "Hair Color", "Facial", "Massage", "Waxing", "Manicure", "Pedicure"]
  has_many :combos, dependent: :destroy
  validates :name, presence: true, uniqueness: true, inclusion: { in: SERVICE_NAMES }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
