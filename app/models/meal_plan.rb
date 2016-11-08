class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes

  def grocery_list
    groceries = Array.new
    delimiter = /\s*\n+\s*/ # 0 or more whitespace characters, 1 or more newline character, 0 or more whitespace characters, I think?
  
    self.recipes.each do |recipe|
      ingredients_lines = recipe.ingredients_block.split(delimiter)
      groceries.concat(ingredients_lines)
    end

    groceries
  end
end
