class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :ingredients, -> { order(:name) }, :as => :parent

  def add_ingredient(add_i)
    # search for the ingredient by name
    # if found, verify that the param ingredient and found ingredient 
    # have summable units. if so, sum the amounts in the recipe and the grocery list
    # if units are not summable, keep searching.
    # if not found, add a new ingredient to the grocery list

    self.ingredients.each do |list_i|
      if list_i.name.singularize == add_i.name.singularize
        if list_i.unitless? || add_i.unitless?
          if list_i.unitless? && add_i.unitless?
            list_i.amount = sum_i(list_i, add_i)
            return list_i.save
          end
        else
          if list_i.unitized_amount.compatible?(add_i.unitized_amount)
            list_i.amount = Unit.new( list_i.unitized_amount + add_i.unitized_amount ).scalar
            return list_i.save
          end
        end
      end
    end
    self.ingredients.create(name: add_i.name, amount: add_i.amount, unit: add_i.unit)
  end

  def subtract_ingredient(sub_i)
    # search for the ingredient by name, then subtract the recipe's amount from the grocery list
    # if amount = 0, remove entirely

    self.ingredients.each do |list_i|
      if list_i.name.singularize == sub_i.name.singularize
        if (list_i.unitized_amount > sub_i.unitized_amount) && list_i.unitized_amount.compatible?(sub_i.unitized_amount)
          list_i.amount = Unit.new( list_i.unitized_amount - sub_i.unitized_amount ).scalar
          return list_i.save
        else
          return self.ingredients.delete(list_i)
        end
      end
    end
  end

  private

  def sum_i(list_i, add_i)
    Unit.new( list_i.unitized_amount + add_i.unitized_amount ).scalar
  end
end
