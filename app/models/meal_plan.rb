class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes,
      after_add: :append_recipe_to_grocery_list,
      after_remove: :remove_recipe_from_grocery_list
  has_many :ingredients, -> { order(:name) }, through: :recipes

  validates_presence_of :user

  def append_recipe_to_grocery_list(recipe)
    recipe.ingredients.map do |recipe_i|
      self.user.grocery_list.add_ingredient(recipe_i)
    end
  end

  def remove_recipe_from_grocery_list(recipe)
    recipe.ingredients.map do |recipe_i|
      self.user.grocery_list.subtract_ingredient(recipe_i)
    end
  end
end
