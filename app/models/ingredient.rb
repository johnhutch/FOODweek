class Ingredient < ApplicationRecord

  def numeric_amount
    # because "2".to_r == 2/1, and no one writes recipes like that
    # so we check to see if the denominator is 1. if so, use to_i. otherwise, .to_r
    if self.amount
      self.amount.to_r.denominator == 1 ? self.amount.to_i : self.amount.to_r
    else
      ""
    end
  end

  def unitized_amount
    Unit.new(self.amount + (self.unit || "") )
  end

  def ingreedy_parse(ing_string)
    begin
      parsed_ing = Ingreedy.parse(ing_string)
      self.name = parsed_ing.ingredient
      self.amount = parsed_ing.amount
      self.unit = parsed_ing.unit
    rescue 
      # ingreedy chokes if you give it an ingredient string that doesn't contain a 
      # quantity. so let's handle that so our app doesn't crash
      self.name = ing_string
    end
  end
end
