class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :recipes, :MealPlans do |t|
      # t.index [:recipe_id, :meal_plan_id]
      # t.index [:meal_plan_id, :recipe_id]
    end
  end
end
