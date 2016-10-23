class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :recipes, :meal_plans do |t|
      t.index :recipe_id
      t.index :meal_plan_id
    end
  end
end
