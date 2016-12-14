class ContentController < ApplicationController
  before_action :authenticate_user!, only: [:grocery_list]

  def home
  end

  def contact
  end

  def terms
  end

  def privacy
  end
  
  def style_guide
  end

  def error
  end
end
