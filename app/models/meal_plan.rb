class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes,
      after_add: :append_ingredients_to_grocery_list,
      after_remove: :remove_ingredients_from_grocery_list
  has_many :ingredients, -> { order(:name) }, through: :recipes

  validates_presence_of :user


  def append_ingredients_to_grocery_list(recipe)
    recipe.ingredients.map do |recipe_i|
      found = false
      self.user.grocery_list.ingredients.each do |list_i|
        if list_i.name == recipe_i.name
          list_i.amount = Unit.new( Unit.new(list_i.amount + (list_i.unit || "") ) + Unit.new(recipe_i.amount + (recipe_i.unit || "") ) ).scalar
          list_i.save
          found = true
        end
      end
      self.user.grocery_list.ingredients.create(name: recipe_i.name, amount: recipe_i.amount, unit: recipe_i.unit) unless found
    end
  end

  def remove_ingredients_from_grocery_list(recipe)
    recipe.ingredients.map do |recipe_i|
    end
  end
end
