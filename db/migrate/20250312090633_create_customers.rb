class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_no, null: false
      t.timestamps
    end

    # Add unique constraints separately
    add_index :customers, :email, unique: true
    add_index :customers, :phone_no, unique: true
  end
end
