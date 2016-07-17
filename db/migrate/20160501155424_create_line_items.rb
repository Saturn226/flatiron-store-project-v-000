class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 1
      t.integer :item_id
      t.integer :cart_id
    end
    add_index :line_items, :item_id
    add_index :line_items, :cart_id
  end
end
