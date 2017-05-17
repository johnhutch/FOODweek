class CreateGroceryLists < ActiveRecord::Migration[5.0]
  def change
    create_table :grocery_lists do |t|
      t.integer :user_id, :unique => true

      t.index :user_id

      t.timestamps
    end
  end
end
