class UsersController < ApplicationController

  def index
  end

  def mypage
  @user = User.find(current_user[:id])
  end

  def login
  end
  
  def mypage_items
    @user = User.find(current_user[:id])
    @item = Item.find_by(user_session)
    @images = @item.images
    end


end
