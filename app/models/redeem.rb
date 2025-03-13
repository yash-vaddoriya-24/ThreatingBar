class Redeem < ApplicationRecord
  belongs_to :customer_comb, required: true
end
