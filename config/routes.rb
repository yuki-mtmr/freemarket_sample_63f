Rails.application.routes.draw do
  devise_for :users

  root to: "items#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "signup", to: "signup#index"
  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4' # ここで、入力の全てが終了する
      get 'complete' # 登録完了後のページ
    end
  end
  


end
