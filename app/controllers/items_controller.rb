class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
  end

  def product_buy
  end
end