class AddTimeToRecipes < ActiveRecord::Migration[5.0]
  def up
    add_column :recipes, :time, :integer
  end

  def down
    remove_column :recipes, :time
  end
end
