class AddLinkToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :link, :string
  end
end
