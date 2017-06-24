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

  def grocery_list
    @grocery_list = current_user.grocery_list

    respond_to do |format|
      format.html { render layout: "basic" }
      format.json { render json: @grocery_list }
    end
  end

end
