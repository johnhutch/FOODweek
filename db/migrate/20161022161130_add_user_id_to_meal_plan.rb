class AddUserIdToMealPlan < ActiveRecord::Migration[5.0]
  def up
    add_reference :meal_plans, :user
  end

  def down
    remove_reference :meal_plans, :user
  end
end
