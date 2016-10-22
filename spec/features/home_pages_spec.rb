require 'rails_helper'

RSpec.feature "home page", type: :feature do
  describe "navigation" do 
    it " shows me the menu" do 
      visit "/"
      expect(page.find('.nav-bar')).to have_content("brand") # page find search for css path
    end
  end
end
