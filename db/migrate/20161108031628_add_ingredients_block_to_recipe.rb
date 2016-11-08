class AddIngredientsBlockToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :ingredients_block, :text
  end
end
