class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :validatable deviseのvalidation無効

  has_one :address,       dependent: :destroy
  accepts_nested_attributes_for :address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  KANA_VALIDATION = /\A[\p{katakana}\p{blank}ー－]+\z/


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
end
