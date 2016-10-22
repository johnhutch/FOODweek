class AddUserToRecipes < ActiveRecord::Migration[5.0]
  def up
    add_reference :recipes, :user
  end

  def down
    remove_reference :recipes, :user
  end
end
