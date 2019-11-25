require 'rails_helper'

describe User do
  describe '#create' do

  #userモデルのvalidationチェック

    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid without a birth_year" do
      user = build(:user, birth_year: nil)
      user.valid?
      expect(user.errors[:birth_year]).to include("can't be blank")
    end

    it "is invalid without a birth_month" do
      user = build(:user, birth_month: nil)
      user.valid?
      expect(user.errors[:birth_month]).to include("can't be blank")
    end

    it "is invalid without a birth_day" do
      user = build(:user, birth_day: nil)
      user.valid?
      expect(user.errors[:birth_day]).to include("can't be blank")
    end

    it "is invalid without a phone_number" do
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it "is valid with a 
    
    nickname,
    email,
    password,
    first_name,
    last_name,
    first_name_kana,
    last_name_kana,
    birth_year,
    birth_month,
    birth_day,
    phone_number" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid with a duplicate email address" do
      #はじめにユーザーを登録
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "111aaa")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

  end
end