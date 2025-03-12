class CreateCombos < ActiveRecord::Migration[8.0]
  def change
    create_table :combos do |t|
      t.references :service, null: false, foreign_key: true
      t.integer :count, null: false
      t.decimal :discount, precision: 5, scale: 2, null: false, default: 0.0
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
