class ItemsController < ApplicationController
  def index
    @items = Item.all
  end 

  def show
    @item = Item.find(params[:id])
    @images = Image.where(item_id: params[:id])
  end

  def product_buy
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to users_path 
  end

  def edit
    @item = Item.find(params[:id])
    @images = @item.images
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to root_path
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
      :image,:id]
    )
    .merge(
      user_id:
      current_user.id)
  end
end