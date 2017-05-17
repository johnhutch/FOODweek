class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :grocery_list_id
      t.string :name
      t.string :amount
      t.string :unit
      t.boolean :checked

      t.index :grocery_list_id

      t.timestamps
    end
  end
end
