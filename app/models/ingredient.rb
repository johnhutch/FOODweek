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

  def amountless?
    self.amount != true
  end

  def unitized_amount
    unless self.amount
      self.amount = 1
    end

    if self.unit
      Unit.new(self.amount + " " + self.unit)
    else
      self.amount.to_i
    end
  end

  def matched?(ing)
      return self.name.singularize == ing.name.singularize
  end

  def sum(ing)
    # verify that ingredients are compatibly unit'd (or not unit'd)
    # could probably be combined with sub(ing) with the math operator sent as a 
    # param but I don't know how to do that.

    if self.amountless? || ing.amountless?
      return false
    end
    if self.unitless? || ing.unitless?
      if self.unitless? && ing.unitless?
        self.amount = Unit.new( self.unitized_amount + ing.unitized_amount ).scalar
        return self.save
      end
    else
      if self.unitized_amount.compatible?(ing.unitized_amount)
        self.amount = Unit.new( self.unitized_amount + ing.unitized_amount ).scalar
        return self.save
      end
    end
    return false
  end

  def sub(ing)
    # verify that both ingredients actually have quantities, then verify that ingredients 
    # are compatibly unit'd (or not unit'd) and then subtract.
    # could probably be combined with sum(ing) with the math operator sent as a param
    # but I don't know how to do that.

    if self.amountless? || ing.amountless?
      return false
    end
    if self.unitless? || ing.unitless?
      if self.unitless? && ing.unitless?
        if (self.amount > ing.amount)
          self.amount = Unit.new( self.unitized_amount - ing.unitized_amount ).scalar
          return self.save
        end
      end
    else
      if self.unitized_amount.compatible?(ing.unitized_amount)
        if (self.unitized_amount > ing.unitized_amount)
          self.amount = Unit.new( self.unitized_amount - ing.unitized_amount ).scalar
          return self.save
        end
      end
    end
    return false
  end

  def ingreedy_parse(ing_string)

    # ingreedy chokes if you give it an ingredient string that doesn't contain a 
    # quantity. so let's handle that so our app doesn't crash
    begin
      parsed_ing = Ingreedy.parse(ing_string)
    rescue
      parsed_ing = false
    end

    # ruby-units chokes if it's not a recognized unit, and we currently have no way
    # of checking valid units ahead of time. so we rescue the exception and handle
    # the conditional after.
    unity = true
    begin
      Unit.new(parsed_ing.amount.to_s + " " + parsed_ing.unit.to_s)
    rescue
      unity = false
    end

    if parsed_ing
      self.amount = parsed_ing.amount
      if unity
        self.name = parsed_ing.ingredient
        self.unit = parsed_ing.unit
      else
        self.name = parsed_ing.unit.to_s + " " + parsed_ing.ingredient.to_s
      end
    else
      self.name = ing_string
    end
  end
end
