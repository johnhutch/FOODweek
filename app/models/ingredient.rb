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
end
