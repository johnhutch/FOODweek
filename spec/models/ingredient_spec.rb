require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:recipe1) { FactoryGirl.create(:recipe, user: user) }
  let(:recipe2) { FactoryGirl.create(:recipe, user: user) }
  let(:ingredient1) { FactoryGirl.create(:ingredient, parent: recipe1) }
  let(:ingredient2) { FactoryGirl.create(:ingredient, parent: recipe2) }
  let(:ingredient3) { FactoryGirl.create(:ingredient, parent: recipe2, amount: 4) }
  let(:ing_liter) { FactoryGirl.create(:ingredient, parent: recipe2, unit: "liter", amount: 4) }
  let(:ing_unitless) { FactoryGirl.create(:ingredient, parent: recipe2, unit: nil, amount: 4) }

  it "is valid with valid attributes" do
		expect(Ingredient.new(name: ingredient1.name, parent: recipe1)).to be_valid
	end

  it "is not valid without a name" do
		expect(Ingredient.new()).to_not be_valid
	end

  it "add two compatibly unit'd ingredients" do
    ingredient3.sum(ingredient2)
    expect(ingredient3.unitized_amount.to_s.partition(" ").first).to eq "5.5"
  end

  it "returns false if trying to add to incompatibly unit'd ingredients" do
    expect(ing_liter.sum(ingredient2)).to eq false
  end

  it "returns false if trying to add to nil unit'd ingredient to a unit'd ingredient" do
    expect(ing_unitless.sum(ingredient2)).to eq false
  end

  it "subtracts two compatibly unit'd ingredients" do
    ingredient3.sub(ingredient2)
    expect(ingredient3.unitized_amount.to_s.partition(" ").first).to eq "2.5"
  end

  it "returns false if trying to subtract equal to or more than the amount available" do
    expect(ingredient1.sub(ingredient2)).to eq false
  end

end
