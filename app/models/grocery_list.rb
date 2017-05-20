class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :ingredients, -> { order(:name) }, :as => :parent
end
