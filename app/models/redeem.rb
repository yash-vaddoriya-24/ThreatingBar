class Redeem < ApplicationRecord
  belongs_to :customer_combo, counter_cache: true
end
