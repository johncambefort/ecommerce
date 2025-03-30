class CreateCartProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_products do |t|
      t.belongs_to :cart
      t.belongs_to :product

      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
