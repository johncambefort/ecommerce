class AddPromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.belongs_to :product

      t.float :discount, null: false, default: 0
      t.integer :discount_type, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end
  end
end
