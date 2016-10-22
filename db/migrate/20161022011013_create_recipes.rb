class CreateRecipes < ActiveRecord::Migration[5.0]
  def up
    create_table :recipes
    add_column :recipes, :name, :string
    add_column :recipes, :ingredients, :text
    add_column :recipes, :steps, :text
  end

  def down
    remove_column :recipes, :steps
    remove_column :recipes, :ingredients
    remove_column :recipes, :name
    drop_table :recipes
  end
end
