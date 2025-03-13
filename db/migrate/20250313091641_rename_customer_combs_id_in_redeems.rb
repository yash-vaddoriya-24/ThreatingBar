class RenameCustomerCombsIdInRedeems < ActiveRecord::Migration[8.0]
  def change
    rename_column :redeems, :customer_combs_id, :customer_comb_id
  end
end
