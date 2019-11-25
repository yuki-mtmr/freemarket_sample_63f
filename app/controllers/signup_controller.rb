class SignupController < ApplicationController
  before_action :validates_step1, only: :step2 # step1のバリデーション
  before_action :validates_step2, only: :step3 # step2のバリデーション
  before_action :validates_step3, only: :step4 # step3のバリデーション


  def step1
    @user = User.new # 新規インスタンス作成
  end

  def validates_step1 #validateion用step
    session[:user_params_after_step1] = user_params #step1で入力したparamsをsessionに代入
    @user = User.new(
      session[:user_params_after_step1]) #validation用にsessionデータを変数に入力
    @user.valid?
    skip_phone_number_validate(@user.errors) #phone_numberをスキップするメソッド

    render :step1 unless @user.errors.messages.blank? && @user.errors.details.blank? #validationによるエラーがあればstep1へ戻る
    
  end


  def step2
    @user = User.new # 新規インスタンス作成
  end

  def validates_step2
    session[:user_params_after_step2] = user_params #step2で入力したparamsをsessionに代入
    session[:user_params_after_step2].merge!(session[:user_params_after_step1]) #step1とstep2のuser情報を結合(step2にstep1を取り込む)
    @user = User.new(
      session[:user_params_after_step2])
    render :step2 unless @user.valid?
  end


  def step3
    @user = User.new # 新規インスタンス作成
    @user.build_address #userテーブルにaddressテーブルを紐付け
  end

  def validates_step3
    session[:address_attributes] = user_params[:address_attributes] #addressの情報をsessionに代入
    @user = User.new(session[:address_attributes])
    render :step3 unless @user.valid?
  end


  def step4
    @user = User.new # 新規インスタンス作成
  end

  def complete
    sign_in User.find(session[:id]) unless user_signed_in? #deviseのメソッドsign_inを活用し、createアクションで作成・保存したデータのidを用いてサインイン
  end


  def create
    @user = User.new(session[:user_params_after_step2]) #user情報をテーブルに作成
    session[:address_attributes] = user_params[:address_attributes] #addressの情報をsessionに代入
    @user.build_address(session[:address_attributes]) #address情報をテーブルに作成
    if @user.save
      session[:id] = @user.id  #　ここでidをsessionに入れることでログイン状態に持っていける。
      redirect_to complete_signup_index_path #登録完了ページに遷移
    else
      render :step1
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
