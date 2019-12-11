class UsersController < ApplicationController

  def index
    # render layout: false
  end

  def mypage
  #  @user = User.find_by(params[:id])
  @user = User.find(current_user[:id])
    # render layout: false
  end

  def login
  end
  
  def mypage_items
    @user = User.find(current_user[:id])
    @item = Item.find_by(user_session)
    @images = @item.images
    end


end
