class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes,
      after_add: :append_ingredients_to_grocery_list,
      after_remove: :remove_ingredients_from_grocery_list
  has_many :ingredients, -> { order(:name) }, through: :recipes

  validates_presence_of :user

  def append_ingredients_to_grocery_list(recipe)
    recipe.ingredients.map do |recipe_i|
      # search for the ingredient by name
      # if found, sum the amounts in the recipe and the grocery list
      # if not found, add a new ingredient to the grocery list
      # TODO: could this be improved with an includes? or more intelligent map?
      found = false
      self.user.grocery_list.ingredients.each do |list_i|
        if list_i.name == recipe_i.name
          list_i.amount = Unit.new( list_i.unitized_amount + recipe_i.unitized_amount ).scalar
          list_i.save
          found = true
          break
        end
      end
      self.user.grocery_list.ingredients.create(name: recipe_i.name, amount: recipe_i.amount, unit: recipe_i.unit) unless found
    end
  end

  def remove_ingredients_from_grocery_list(recipe)
    recipe.ingredients.map do |recipe_i|
      # search for the ingredient by name, then subtract the recipe's amount from the grocery list
      # if amount = 0, remove entirely
      # TODO: could this be improved with an includes? or more intelligent map?
      self.user.grocery_list.ingredients.each do |list_i|
        if list_i.name == recipe_i.name
          if list_i.unitized_amount > recipe_i.unitized_amount
            list_i.amount = Unit.new( list_i.unitized_amount - recipe_i.unitized_amount ).scalar
            list_i.save
          else
            self.user.grocery_list.ingredients.delete(list_i)
          end
          break
        end
      end
    end
  end
end
