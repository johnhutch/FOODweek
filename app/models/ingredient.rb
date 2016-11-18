class Ingredient < ApplicationRecord
  def numeric_amount
      self.amount.to_r.denominator == 1 ? self.amount.to_i : self.amount.to_r
  end
end
