class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes
  has_many :ingredients, -> { order(:name) }, :as => :parent

  after_save :parse_grocery_list

  # grabs the ingredients from all of the recipes belonging to the meal plan
  # and attaches them to the meal_plan. Creates duplicate DB entries, but 
  # ends up with a nicely cached grocery list
  def parse_grocery_list
    self.ingredients.delete_all

    self.recipes.each do |recipe|
      self.ingredients << recipe.ingredients
    end
  end

end
