class CardsController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action :set_card

  # 後ほど登録したクレジットの表示画面を作成します。
  def index
  end

  # クレジットカード情報入力画面
  def new
    if @card
      redirect_to card_path unless @card
    else
      render 'signup/credit_card'
    end
  end

  # 登録画面で入力した情報をDBに保存
  def create
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      render 'signup/credit_card'
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id} # 記述しなくても大丈夫です
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to complete_signup_index_path
      else
        render 'signup/credit_card'
      end
    end
  end

  # 後ほど削除機能を実装します。
  def destroy
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end