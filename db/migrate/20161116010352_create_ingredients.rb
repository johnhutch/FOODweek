class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.integer :parent_id
      t.string :unit
      t.float :amount
      t.string :name

      t.timestamps
    end
  end
end
