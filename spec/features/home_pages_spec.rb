require 'rails_helper'

RSpec.feature "home page", type: :feature do
  describe "homepage" do 
    it " shows up because we haven't completely destroyed the site" do 
      visit "/"
      expect(page.find('header')).to have_content( I18n.t('brand') ) # page find search for css path
    end
  end
end
