class SignupController < ApplicationController
  
  before_action :validates_profile, only: :sms_confirmation# step1のバリデーション
  before_action :validates_sms_confirmation, only: :address # step2のバリデーション
  #before_action :validates_address, only: :credit_card # step3のバリデーション


  def profile
    @user = User.new # 新規インスタンス作成
  end

  def validates_profile #validateion用step
    session[:user_params_after_profile] = user_params #profile登録画面で入力したparamsをsessionに代入
    @user = User.new(
      session[:user_params_after_profile]) #validation用にsessionデータを変数に入力
    @user.valid?
    skip_phone_number_validate(@user.errors) #phone_numberをスキップするメソッド

    render :profile unless @user.errors.messages.blank? && @user.errors.details.blank? #validationによるエラーがあればstep1へ戻る
    
  end


  def sms_confirmation
    @user = User.new # 新規インスタンス作成
  end

  def validates_sms_confirmation
    session[:user_params_after_sms_confirmation] = user_params #sms認証で入力したparamsをsessionに代入
    session[:user_params_after_sms_confirmation].merge!(session[:user_params_after_profile]) #profileと電話番号のuser情報を結合
    @user = User.new(
      session[:user_params_after_sms_confirmation])
    render :sms_confirmation unless @user.valid?
  end


  def address
    @user = User.new # 新規インスタンス作成
    @user.build_address #userテーブルにaddressテーブルを紐付け
  end

  def validates_address
    session[:address_attributes] = user_params[:address_attributes] #addressの情報をsessionに代入
    @user = User.new(session[:address_attributes])
    render :address unless @user.valid?
  end


  def credit_card
    @user = User.new # 新規インスタンス作成
    sign_in User.find(session[:id]) unless user_signed_in? #deviseのメソッドsign_inを活用し、createアクションで作成・保存したデータのidを用いてサインイン
    redirect_to cards_path
  end

  def complete
  end


  def create
    @user = User.new(session[:user_params_after_sms_confirmation]) #user情報をテーブルに作成
    session[:address_attributes] = user_params[:address_attributes] #addressの情報をsessionに代入
    @user.build_address(session[:address_attributes]) #address情報をテーブルに作成
    if @user.save
      session[:id] = @user.id  #　ここでidをsessionに入れることでログイン状態に持っていける。
      redirect_to credit_card_signup_index_path #登録完了ページに遷移
    else
      render :profile
    end
  end

  private
    def user_params #userのストロングparmsにaddressparamsを埋め込み
      params.require(:user).permit(
        :nickname,
        :email,
        :password,
        :password_confirmation,
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,
        :birth_year,
        :birth_month,
        :birth_day,
        :phone_number,
        address_attributes: [
          :id,
          :first_name,
          :last_name,
          :first_name_kana,
          :last_name_kana,
          :postal_code,
          :region,
          :city,
          :street,
          :building,
          :phone_number,]
    )
    end

    #step1で入力しない電話番号をスキップ
    def skip_phone_number_validate(errors)
      errors.messages.delete(:phone_number)  #stepの回数や入力するデータに合わせて変更してください
      errors.details.delete(:phone_number)
    end
  
end
