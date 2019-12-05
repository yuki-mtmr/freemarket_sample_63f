Rails.application.routes.draw do

  devise_for :users

  root to: "items#index"
  post "/" => "items#create"
  resources :items, only: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  resources :users, only: [:index] do
    collection do
      get '_logout'
      get '_new-myprofile'
      get '_side-bar'
      get 'login'
      get 'mypage'
      get '_edit-profile'
      get '_card_registration'
    end
  end

  
  resources :items, only: [:show, :index] do
    collection do
      get 'product_buy'
    end
  end
  

  resources :cards , only: [:new, :index, :create, :destroy]


  get "signup", to: "signup#index"
  resources :signup do
    collection do
      get 'profile'
      get 'sms_confirmation' #SMS認証は未実装のため今は電話番号の登録のみ
      get 'address' #住所の登録、credit_cad入力画面に遷移してcreateアクションを動かし、ユーザーを保存
      get 'credit_card' #
      get 'complete' # 登録完了後のページ
    end
  end
end
