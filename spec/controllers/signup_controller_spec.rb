require 'rails_helper'

RSpec.describe SignupController, type: :controller do
  describe "get #step1" do
    it "レスポンスが成功すること" do
      get :step1
      expect(response).to be_successful
    end

    #200レスポンスは成功というステート
    it "200レスポンスを返すこと" do
      get :step1
      expect(response).to have_http_status "200"
    end
  end

  describe "#step1_validates" do
    context "有効なデータの場合" do 
      #　同じ処理はsubjectを使うことでｄｒｙにし同じデータを使っているとわかりやすくする
      subject {
        user_params = attributes_for(:user)
        #post　:アクション名, params: { パラメータ名: "値"}, session: { session名: "値" } でデータを指定できる
        get :validates_step1, params: { user: user_params},
                                session: {
                                  nickname: "tanegashiman",
                                  email: "kkk@gmail.com",
                                  password: "123456a",
                                  last_name: "向井",
                                  first_name: "治",
                                  last_name_kana: "ムカイ",
                                  first_name_kana: "オサム",
                                  birth_year: 2018,
                                  birth_month: 12,
                                  birth_day: 31
                                }
      }
       #200レスポンスはリダイレクト成功というステート
      it "302レスポンスを返すこと" do
        #設定したsubjectはこのように使う
        subject
        expect(response).to have_http_status "302"
      end

      it "電話番号確認ページにリダイレクトすること" do
        subject
        expect(response).to redirect_to step2_signup_index_path
      end
    end

    context "無効なデータの場合" do
      subject {
        #無効なデータのときは処理の流れを理解しているとスムーズに進む
        user_params = attributes_for(:user, nickname: "")
        post :validates_step1, params: { user: user_params},
                              session: {
                                nickname: '',
                                email: "kkk@gmail.com",
                                password: "123456a",
                                last_name: "向井",
                                first_name: "治",
                                last_name_kana: "ムカイ",
                                first_name_kana: "オサム",
                                birth_year: 2018,
                                birth_month: 12,
                                birth_day: 31
                              }
      }

      it "200レスポンスを返すこと" do
        subject
        expect(response).to have_http_status "200"
      end

      it "step1にrenderすること" do
        subject
        expect(response).to render_template :step1
      end
    end
  end

  describe "get #step2" do
  before do
    # ここで定義しないとsessionがないと怒られる
    user_params = attributes_for(:user)
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
  end
    it "レスポンスが成功すること" do
      get :step2
      expect(response).to be_successful
    end

    it "200レスポンスを返すこと" do
      get :step2
      expect(response).to have_http_status "200"
    end
  end

  describe "create" do
    context "有効なデータの場合" do
      subject {
        user_params = attributes_for(:user)
        post :create, params: { user: user_params},
                      session: {
                        nickname: "tanegashiman",
                        email: "kkk@gmail.com",
                        password: "123456a",
                        last_name: "向井",
                        first_name: "治",
                        last_name_kana: "ムカイ",
                        first_name_kana: "オサム",
                        birth_year: 2018,
                        birth_month: 12,
                        birth_day: 31
                      }
      }
      it "302レスポンスを返すこと" do
        subject
        expect(response).to have_http_status "302"
      end

      it "送付先登録ページにリダイレクトされること" do
        subject
        expect(response).to redirect_to complete_signup_index_path
      end

      it "保存することができる" do
        user_params = attributes_for(:user)
        expect do
          subject
        end.to change { User.count }.by(1)
      end
    end

    context "無効なデータの場合" do
      subject {
        user_params = attributes_for(:user)
        post :create, params: { user: user_params},
                    session: {
                      nickname: "",
                      email: "kkk@gmail.com",
                      password: "123456a",
                      last_name: "向井",
                      first_name: "治",
                      last_name_kana: "ムカイ",
                      first_name_kana: "オサム",
                      birth_year: 2018,
                      birth_month: 12,
                      birth_day: 31
                    }
      }
      it "200レスポンスを返すこと" do
        subject
        expect(response).to have_http_status "200"
      end

      it "step2にrenderされること" do
        subject
        expect(response).to render_template :step2
      end

      it "保存することができない" do
        expect do
          subject
        end.to change { User.count }.by(0)
      end
    end
  end
end