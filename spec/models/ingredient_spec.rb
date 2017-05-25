require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:ingredient) { FactoryGirl.create(:ingredient, parent: recipe) }

  it "is valid with valid attributes" do
		expect(Ingredient.new(name: ingredient.name, parent: recipe)).to be_valid
	end

  it "is not valid without a name" do
		expect(Ingredient.new()).to_not be_valid
	end

end
