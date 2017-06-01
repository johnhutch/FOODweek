class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes
  has_many :ingredients, -> { order(:name) }, through: :recipes
end
