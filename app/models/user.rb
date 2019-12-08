class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, #:validatable deviseのvalidation無効
          :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_one  :address,       dependent: :destroy
  has_many :cards,         dependent: :destroy
  has_many :items,         dependent: :destroy
  has_many :salers,        dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  accepts_nested_attributes_for :address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  KANA_VALIDATION = /\A[\p{katakana}\p{blank}ー－]+\z/

  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"


  validates :email,                   presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 7, maximum: 128},    format: { with: PASSWORD_VALIDATION }
  validates :nickname,                presence: true, length: {maximum: 20}
  validates :first_name,              presence: true
  validates :last_name,               presence: true
  validates :first_name_kana,         presence: true, format: { with: KANA_VALIDATION, message: 'はカタカナで入力して下さい。'}
  validates :last_name_kana,          presence: true, format: { with: KANA_VALIDATION, message: 'はカタカナで入力して下さい。'}
  validates :birth_year,              presence: true
  validates :birth_month,             presence: true
  validates :birth_day,               presence: true

  validates :phone_number,            presence: true


  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.find_by(uid: uid, provider: provider)

    #sns_credentialsが登録されている
    if snscredential.present?
      user = User.find_by(email: auth.info.email)

      # userが登録されていない
      unless user.present?
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
      end
      sns = snscredential
      #返り値をハッシュにして扱いやすくする  
      #活用例 info = User.find_oauth(auth) 
             #session[:nickname] = info[:user][:nickname]
      { user: user, sns: sns}

    #sns_credentialsが登録されていない
    else
      user = User.find_by(email: auth.info.email)


      # userが登録されている
      if user.present?
        sns = SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
        )

        { user: user, sns: sns}

      # userが登録されていない
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: uid,
          provider: provider
        )

        return { user: user, sns: sns}
      end
    end
  end
end