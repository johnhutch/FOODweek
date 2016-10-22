class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :ingredients, presence: true
  validates :steps, presence: true
  validates :time, presence: true, numericality: { presence: true, only_integer: true, greater_than: 0 }
  validates :user_id, presence: true
end
