require 'rails_helper'

RSpec.describe GroceryList, type: :model do
  it "is valid with valid attributes" do
    user = FactoryGirl.create(:user)
		expect(GroceryList.new(user_id: user.id)).to be_valid
	end

  it "is not valid without a user" do
		expect(GroceryList.new()).to_not be_valid
	end

end
