class UsersController < ApplicationController

  def index
    # render layout: false
  end

  def mypage_items
    @item = Item.find_by(user_session)
    @images = @item.images
    @prefecture =  Prefecture.find(@item.region)
  end

  def login
  end

  def mypage
  end
  
  


end
