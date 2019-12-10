class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:index, :pay]

  def index
    #Cardテーブルからpayjpの顧客IDを検索
    @item = Item.find_by(id: params[:format])
    @images = @item.images
    @address = current_user.address #current_userからアソシエーションで取ってくる
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "cards", action: "index"
    else
      if Rails.env.development?
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      else
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      end
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      session[:item] = @item
      session[:images] = @images
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end


  def pay
    @item = session[:item]
    @images = session[:images]
    if Rails.env.development?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
    end
    Payjp::Charge.create(
    :amount => @item['price'], #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => @card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    redirect_to action: 'create' #完了画面に移動
  end

  def create
    saler = Saler.new(
      user_id: current_user.id,
      item_id: session[:item]['id'],
    )
    item = Item.find(session[:item]['id'])
    item.status = 1
    item.save
    saler.save
    redirect_to root_path
  end

  def done
  end

  def set_card
    @card = current_user.cards.first #メソッド外に変数を渡すときは@をつける
  end

end