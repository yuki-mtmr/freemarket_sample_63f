class ItemsController < ApplicationController
  protect_from_forgery :except => [:destroy]
  before_action :set_item, only: [:edit, :update, :destroy]
  
  def index
    @items = Item.all
  end

  def show
  end

  def product_buy
  end

  def destroy
    # item = Item.find(params[:id])
    @item.destroy 
    redirect_to("/items")
  end

  def edit
  end


  def update
    @item.update(item_params)
    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:goods, { :item_ids => [] })
  end

end