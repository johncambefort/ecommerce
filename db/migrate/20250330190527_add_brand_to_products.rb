class AddBrandToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :brand, :string, null: false, default: 'Trader Joes'
  end
end
