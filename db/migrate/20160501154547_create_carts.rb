class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :status, default: "not submitted"
    end
    add_index :carts, :user_id
  end
end
