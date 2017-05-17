class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :ingredients, :as => :parent
end
