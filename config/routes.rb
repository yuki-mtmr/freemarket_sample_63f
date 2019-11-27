Rails.application.routes.draw do
  devise_for :users

  root to: "items#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index]

  get "signup", to: "signup#index"
  resources :signup do
    collection do
      get 'profile'
      get 'sms_confirmation' #SMS認証は未実装のため今は電話番号の登録のみ
      get 'address' #まだcredit_cardの実装前なのでここで登録完了画面に遷移
      get 'credit_card' # ここで、入力の全てが終了する
      get 'complete' # 登録完了後のページ
    end
  end
  


end
