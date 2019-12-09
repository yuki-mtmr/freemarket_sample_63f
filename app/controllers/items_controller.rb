class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @images = Image.find(params[:id])
  end

  def product_buy
  end

  def new
      @item = Item.new
      2.times{@item.images.build}
  end

  def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to root_path
      else
        render :new
      end
  end

  private

  def item_params
    params.require(:item).permit(
      :price, 
      :name, 
      :description, 
      :condition, 
      :postage, 
      :region, 
      :shipping_date, 
      images_attributes: [
      :image]
    )
    .merge(
      user_id:
      current_user.id)
  end
end