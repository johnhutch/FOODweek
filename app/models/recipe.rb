class Recipe < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :meal_plans

  validates :name, presence: true
  validates :ingredients_block, presence: true
  validates :steps, presence: true
  validates :time, presence: true, numericality: { presence: true, only_integer: true, greater_than: 0 }
  validates :user_id, presence: true

  def ingredients_formatted
    groceries = Array.new
    delimiter = /\s*\n+\s*/ # 0 or more whitespace characters, 1 or more newline character, 0 or more whitespace characters, I think?
    ingredients_lines = self.ingredients_block.split(delimiter)
    groceries.concat(ingredients_lines)
    groceries
  end
end
