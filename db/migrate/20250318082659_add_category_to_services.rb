class AddCategoryToServices < ActiveRecord::Migration[8.0]
  def change
    add_column :services, :category, :string
  end
end
