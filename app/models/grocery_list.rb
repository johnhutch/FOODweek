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
      if list_i.matched?(add_i)
        if list_i.sum(add_i)
          return true
        end
      end
    end
    self.ingredients.create(name: add_i.name, amount: add_i.amount, unit: add_i.unit)
  end

  def subtract_ingredient(sub_i)
    # search for the ingredient by name, then subtract the recipe's amount from the grocery list
    # if resultant amount would be <= 0, remove entirely

    self.ingredients.each do |list_i|
      if list_i.matched?(sub_i)
        if list_i.sub(sub_i)
          return true
        else
          return self.ingredients.delete(list_i)
        end
      end
    end
  end

end
