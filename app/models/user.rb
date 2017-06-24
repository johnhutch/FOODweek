class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :meal_plans
  has_one :grocery_list

  after_create :attach_list

  def current_meal_plan
    self.meal_plans.last
  end

  def attach_list
    self.create_grocery_list
  end
end
