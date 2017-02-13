class Recipe < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :meal_plans
  has_many :ingredients, :as => :parent

  validates :name, presence: true
  validates :ingredients_block, presence: true
  validates :steps, presence: true
  validates :time, presence: true, numericality: { presence: true, only_integer: true, greater_than: 0 }
  validates :user_id, presence: true

  after_save :parse_ingredient_block

  def ingredients_formatted
    groceries = Array.new
    delimiter = /\s*\n+\s*/ # 0 or more whitespace characters, 1 or more newline character, 0 or more whitespace characters, I think?
    ingredients_lines = self.ingredients_block.split(delimiter)
    groceries.concat(ingredients_lines)
    groceries
  end

  def parse_ingredient_block
    self.ingredients.delete_all
    delimiter = /\s*\n+\s*/ # 0 or more whitespace characters, 1 or more newline character, 0 or more whitespace characters, I think?

    # take the text block of ingredients
    # treat each new line as its own individual ingredienet
    # use ingreedy to parse out the amount, unit, and name and save in
    # an associated ingredient record
    self.ingredients_block.split(delimiter).each do |ingredient|
      begin
        parsed_ing = Ingreedy.parse(ingredient)
        self.ingredients << Ingredient.create(name: parsed_ing.ingredient, amount: parsed_ing.amount, unit: parsed_ing.unit)
      rescue 
        # ingreedy chokes if you give it an ingredient string that doesn't contain a quantity. so let's handle that so our 
        # app doesn't crash
        self.ingredients << Ingredient.create(name: ingredient)
      end
    end
  end
end
