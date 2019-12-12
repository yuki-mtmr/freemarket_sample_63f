class ItemsController < ApplicationController
  before_action :set_item,only:[:show,:edit,:destroy,:update]

  def index
    @items = Item.all
  end 

  def show
    @images = Image.where(item_id: params[:id])
    @prefecture =  Prefecture.find(@item.region)
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

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to uers_path
    end
  end

  def edit
    @images = @item.images
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
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

  def set_item
    @item = Item.find(params[:id])
  end

end