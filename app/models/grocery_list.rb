class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :ingredients, -> { order(:name) }, :as => :parent

  def add_ingredient(add_i)
    # search for the ingredient by name
    # if found, sum the amounts in the recipe and the grocery list
    # if not found, add a new ingredient to the grocery list
    # TODO: could this be improved with an includes? or more intelligent map?

    self.ingredients.each do |list_i|
      if list_i.name == add_i.name
        list_i.amount = Unit.new( list_i.unitized_amount + add_i.unitized_amount ).scalar
        return list_i.save
      end
    end
    self.ingredients.create(name: add_i.name, amount: add_i.amount, unit: add_i.unit)
  end

  def subtract_ingredient(sub_i)
    # search for the ingredient by name, then subtract the recipe's amount from the grocery list
    # if amount = 0, remove entirely
    # TODO: could this be improved with an includes? or more intelligent map?

    self.ingredients.each do |list_i|
      if list_i.name == sub_i.name
        if list_i.unitized_amount.nil? || list_i.unitized_amount > sub_i.unitized_amount
          list_i.amount = Unit.new( list_i.unitized_amount - sub_i.unitized_amount ).scalar
          return list_i.save
        else
          return self.ingredients.delete(list_i)
        end
      end
    end
  end

end
