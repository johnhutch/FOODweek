class Ingredient < ApplicationRecord
  belongs_to :parent, polymorphic: true
  validates_presence_of :name

  def numeric_amount
    # because "2".to_r == 2/1, and no one writes recipes like that
    # so we check to see if the denominator is 1. if so, use to_i. 
    # if not, we check to see if we're dealing with any whole numbers,
    # e.g., 2 3/4, or just sub-1 numbers, e.g., 1/4
    # and display the appropriate formatting
    if self.amount
      den = self.amount.to_r.denominator
      num = self.amount.to_r.numerator

      if den == 1
        self.amount.to_i 
      else
        if den > 32
          self.amount.to_r.to_f.round(2)
        else
          if den > num
            self.amount.to_r
          else
            (num / den).to_i.to_s + " " + (num % den).to_s + "/" + den.to_s
          end
        end
      end
    else
      ""
    end
  end

  def unitless?
    self.unit.nil?
  end

  def unitized_amount
    if self.unit
      Unit.new(self.amount + " " + self.unit)
    else
      self.amount
    end
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
